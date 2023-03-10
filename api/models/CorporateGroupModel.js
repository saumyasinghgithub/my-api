const _ = require("lodash");
const BaseModel = require("./BaseModel");
const fs = require("fs");
const path = require("path");
const moment = require("moment");
const { parse } = require("csv-parse");
const UserModel = require("./UserModel");
const CourseModel = require("./CourseModel");
const MoodleAPI = require("./MoodleAPI");
const PaymentModel = require("./PaymentModel");

class CorporateGroupModel extends BaseModel {
  table = "corporate_groups";
  studentTable = "corporate_groups_students";
  importTable = "import_students";
  pageLimit = 10;

  fetchStats(trainer_id) {
    let ret = { success: false };
    let sql = `SELECT id,name,created_at,(SELECT count(id) FROM ${this.studentTable} WHERE cg_id=cg.id) students,(SELECT count(id) FROM ${this.importTable} WHERE cg_id=cg.id) processing FROM ${this.table} cg WHERE trainer_id=${trainer_id}`;
    return this.db.run(sql).then((res) => {
      if (res) {
        ret["success"] = true;
        ret["data"] = res;
      } else {
        ret["error"] = "No data found";
      }
      return ret;
    });
  }

  fetchDetail(id, trainer_id) {
    let ret = {
      success: false,
      error: "Permission denied",
      cg: false,
      students: [],
      mycourses: [],
    };

    return this.find(id)
      .then((rec) => {
        if (rec.trainer_id === trainer_id) {
          ret.cg = rec;
          return this.fetchStudents(rec.id);
        } else {
          return false;
        }
      })
      .then((usr) => {
        if (usr && ret.cg) {
          ret.students = usr;
          return new CourseModel().list({
            whereStr: `user_id=${trainer_id} AND moodle_id IS NOT NULL`,
            limit: 9999999,
            fields: "id,name,sku",
          });
        } else {
          return false;
        }
      })
      .then((courses) => {
        ret.mycourses = courses.data;
        ret.success = true;
        ret.error = "";
      })
      .then(() => ret);
    /*
      .finally(() => ret);*/
  }

  fetchStudents(cgid) {
    return new UserModel()
      .list({
        fields: `id,CONCAT_WS(' ',firstname,middlename,lastname) as name,email`,
        whereStr: `id IN (SELECT student_id FROM ${this.studentTable} WHERE cg_id=${cgid}) AND moodle_id IS NOT NULL`,
        sortBy: "name",
      })
      .then((usr) => usr.data);
  }

  import(cg_id, csv) {
    return new Promise((resolve, reject) => {
      let fpath = path.resolve("public", "uploads", csv.name);
      csv.mv(fpath, (err) => {
        if (err) {
          reject(err);
        } else {
          this.importFileData(fpath, cg_id).then(() => {
            fs.unlinkSync(fpath);
            resolve({ success: true });
          });
        }
      });
    });
  }

  importFileData(fpath, cg_id) {
    const ism = new ImportStudentModel();
    return new Promise((resolve, reject) => {
      fs.createReadStream(fpath, {
        encoding: "UTF-8",
      })
        .on("error", (err) => {
          reject("file not found.");
        })
        .pipe(parse({ columns: true }))
        .on("error", (err) => {
          console.log("INVALID FILE FORMAT");
          reject("Invalid file format of your uploaded csv.");
        })
        .on("data", (row) => {
          return ism.add({ record: JSON.stringify(row), cg_id: cg_id });
        })
        .on("end", () => {
          resolve();
        });
    });
  }

  processRecords(limit = 10) {
    return new Promise((resolve, reject) => {
      let idx = -1;
      let records = [];
      const startProcessing = () => {
        if (++idx >= records.length) {
          resolve({
            success: true,
            message: `Total processed: ${records.length}`,
          });
        } else {
          let rec = records[idx];
          new UserModel()
            .add({
              ...JSON.parse(rec["record"]),
              role: parseInt(process.env.STUDENT_ROLE),
              password: "Qw@123456",
            })
            .then((rec1) => {
              if (_.get(rec1, "insertId", 0) > 0) {
                return new CGSModel().add({
                  cg_id: rec.cg_id,
                  student_id: rec1.insertId,
                });
              } else {
                reject("skipping");
              }
            })
            .then(() => new ImportStudentModel().delete(rec["id"]))
            .finally(startProcessing);
        }
      };
      this.pickRecords(limit)
        .then((res) => {
          if (_.get(res, "data.length", 0) > 0) {
            records = res.data;
            startProcessing();
          } else {
            reject({ message: "No data found" });
          }
        })
        .catch(reject);
    });
  }

  pickRecords(limit = 10) {
    return new ImportStudentModel().list({
      start: 0,
      limit: limit,
      whereStr: "imported_at IS NULL",
    });
  }

  assign({ cgid, courseid, userids }) {
    let course = {};
    let cgc_moodle_id = null;
    return new CourseModel()
      .find(courseid)
      .then((c) => (course = c))
      .then(() => new CGCModel().getMoodleId(cgid, userids, course))
      .then((mid) => (cgc_moodle_id = mid))
      .then(() => this.enrollUsers2Course(userids, course))
      .then((user_moodle_ids) => new MoodleAPI().addMembersToGroup(cgc_moodle_id, user_moodle_ids));
  }

  enrollUsers2Course(userids, course) {
    let user_moodle_ids = null,
      allUsers = [];
    return (
      new UserModel()
        .list({
          fields: "email,firstname,moodle_id",
          whereStr: `id IN (${userids}) AND role_id=${process.env.STUDENT_ROLE} AND moodle_id IS NOT NULL`,
        })
        .then((users) => {
          allUsers = users.data;
          user_moodle_ids = allUsers.map((u) => u.moodle_id);
        })
        .then(() => new MoodleAPI().setCourseUsers(user_moodle_ids, course.moodle_id))
        //==== need to add users to student_enrollement here
        .then(() => this.emailUsers(allUsers, course))
        .then(() => user_moodle_ids)
    );
  }

  emailUsers(users, course) {
    return new Promise((resolve, reject) => {
      let idx = 0;
      const emailUser = () => {
        if (_.get(users, idx, false) === false) {
          resolve();
        } else {
          let user = users[idx++];
          console.log(user);
          new PaymentModel().notifyEnrolledUser({ email: user.email, username: user.firstname, courseName: course.name }).finally(emailUser);
        }
      };
      emailUser();
    });
  }
}

class ImportStudentModel extends BaseModel {
  table = "import_students";
}

class CGSModel extends BaseModel {
  table = "corporate_groups_students";
}

class CGCModel extends BaseModel {
  table = "corporate_groups_courses";

  getMoodleId(cgid, userids, course) {
    return this.list({
      fields: "moodle_id, student_ids",
      where: { cg_id: cgid, course_id: course.id },
      whereStr: "moodle_id IS NOT NULL",
      limit: 1,
    }).then((res) => {
      if (res.length === 1) {
        return res[0];
      } else {
        let moodleId = null;
        return this.createCGC(cgid, course.moodle_id)
          .then((mid) => (moodleId = mid))
          .then(() =>
            this.add({
              cg_id: cgid,
              course_id: course.id,
              student_ids: JSON.stringify(userids.split(",")),
              moodle_id: moodleId,
            })
          )
          .then(() => moodleId);
      }
    });
  }

  createCGC(cgid, course_moodle_id) {
    let data = { course_moodle_id: course_moodle_id, gname: "", gdesc: "" };
    return new CorporateGroupModel()
      .find(cgid)
      .then((cg) => (data = { ...data, gname: cg.name, gdesc: cg.details }))
      .then(() => new MoodleAPI().createCourseGroup(data))
      .then((res) => res[0].id);
  }
}

module.exports = CorporateGroupModel;
