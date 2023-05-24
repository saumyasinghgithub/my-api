const BaseModel = require("./BaseModel");
const _ = require("lodash");
const path = require("path");
const moment = require("moment");
const fs = require("fs");

class SettingsModel extends BaseModel {
  table = "settings";
  updated_at = true;

  getsiteData({ trainer_id, trainer_self }) {
    let ret = { type: "trainer" },
      trainersetting = {},
      sitesetting = {};
    return this.db.run(`SELECT settings.* FROM settings WHERE settings.trainer_id = ? OR id=1`, [trainer_id]).then((data) => {
      if (data.length === 1) {
        ret["type"] = "default";
        sitesetting = { ...data[0] };
        data.push({});
      } else {
        trainersetting = { ..._.filter(data, (d) => d.id !== 1)[0] };
        sitesetting = { ..._.filter(data, (d) => d.id === 1)[0] };
      }

      if (trainer_self) {
        ret["data"] = { ...trainersetting };
      } else {
        ret["data"] = { ...sitesetting, ..._.omitBy(trainersetting, (v) => _.isNull(v) || _.isEmpty(v)) };
      }

      return { success: true, data: { ...ret } };
    });
  }

  siteData(siteData) {
    let ret = { type: "default", success: false };
    return new Promise((resolve, reject) => {
      this.db
        .run(`SELECT settings.* FROM settings WHERE settings.trainer_id = ?`, [siteData.id])
        .then((data) => {
          if (data.length === 0) {
            console.log("default value will come !");
            return new Promise((resolve, reject) => {
              this.db
                .run(`SELECT settings.* FROM settings WHERE settings.id = 1`)
                .then((newdata) => {
                  ret.success = true;
                  ret["type"] = "default";
                  ret["data"] = newdata;
                })
                .catch((err) => {})
                .finally(() => resolve(ret));
            });
          } else {
            console.log("trainer value will come !");
            ret.success = true;
            ret["type"] = "trainer";
            ret["data"] = data;
          }
        })
        .catch()
        .finally(() => resolve(ret));
    });
  }
  /*siteData(siteData) {
    console.log(siteData);
    let ret = { type: "default" };
    return new Promise((resolve, reject) => {
      this.db
        .run(
          `SELECT trainer_about.user_id FROM trainer_about WHERE trainer_about.slug = ?`,
          [siteData.slug]
        )
        .then((data) => {
          console.log(data);
          console.log(data[0].user_id);
          if (data[0].user_id) {
            return this.db
              .run(
                `SELECT settings.* FROM settings WHERE settings.trainer_id = ?`,
                [data[0].user_id]
              )
              .then((res) => {
                console.log(res);
                if (res.length === 0) {
                  console.log("default value will come !");
                  return this.db
                    .run(
                      `SELECT settings.* FROM settings WHERE settings.id = 1`
                    )
                    .then((newres) => {
                      console.log(newres);
                      ret["type"] = "default";
                      ret["data"] = newres;
                    });
                } else {
                  console.log("trainer value will come !");
                  ret["type"] = "trainer";
                  ret["data"] = res;
                }
              });
          }
        })
        .catch()
        .finally(() => resolve(ret));
    });
  }*/
  uploadImage(data, file, ftype) {
    return new Promise((resolve, reject) => {
      if (!file) {
        resolve(_.get(data, `old_${ftype}`, ""));
      }
      if (_.get(file, "size", 0) > 0) {
        let fname = ftype + "_" + _.get(data, "id", "new") + "_" + moment().unix() + file.name;
        let fpath = path.resolve("public", "uploads", ftype, fname);
        file.mv(fpath, (err) => {
          if (err) {
            reject(err);
          } else {
            this.deleteImage(ftype, _.get(data, `old_${ftype}`, ""));
            resolve(fname);
          }
        });
      } else {
        resolve(_.get(data, `old_${ftype}`, ""));
      }
    });
  }
  deleteImage(folder, fname) {
    let fpath = path.resolve("public", "uploads", folder, fname);
    if (!_.isEmpty(fname) && fs.existsSync(fpath)) {
      fs.unlinkSync(fpath);
    }
  }

  save(data, files, user_id) {
    let dbData = _.pick(data, ["company_name", "company_url", "contact_email", "contact_address", "contact_phone", "copyright_text"]);

    dbData["preferred_trainers"] = _.get(data, "preferred_trainers", false);
    dbData["preferred_courses"] = _.get(data, "preferred_courses", false);
    dbData["trainer_id"] = user_id;

    const uploader = (fldname) => {
      return new Promise((resolve, reject) => {
        this.uploadImage(data, _.get(files, fldname, false), fldname).then((fname) => {
          if (_.get(data, `delete${fldname}`, "0") === "1") {
            let oldfname = _.get(data, `old_${fldname}`, "");
            this.deleteImage(fldname, oldfname);
            resolve(oldfname === fname ? "" : fname);
          } else {
            resolve(fname);
          }
        });
      });
    };

    return uploader("logo")
      .then((fname) => (dbData["logo"] = fname))
      .then(() => uploader("favicon"))
      .then((fname) => (dbData["favicon"] = fname))
      .then(() => this.findBy({ fname: "trainer_id", fvalue: user_id }))
      .then((res) => {
        if (res.length > 0) {
          return super.edit(dbData, res[0].id);
        } else {
          return super.add(dbData);
        }
      });
  }
}

module.exports = SettingsModel;
