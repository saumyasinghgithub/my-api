const BaseModel = require("./BaseModel");
const _ = require("lodash");
const path = require("path");
const moment = require("moment");
const fs = require("fs");

class SettingsModel extends BaseModel {
  table = "settings";
  pageLimit = 10;

  getsiteData(siteData, user_id) {
    console.log("I am here");
    let ret = { type: "default" };
    return new Promise((resolve, reject) => {
      this.db
        .run(`SELECT settings.* FROM settings WHERE settings.trainer_id = ?`, [
          user_id,
        ])
        .then((data) => {
          if (data.length === 0) {
            console.log("default value will come !");
            return new Promise((resolve, reject) => {
              this.db
                .run(`SELECT settings.* FROM settings WHERE settings.id = 1`)
                .then((newdata) => {
                  ret["type"] = "default";
                  ret["data"] = newdata;
                })
                .catch((err) => {})
                .finally(() => resolve(ret));
            });
          } else {
            console.log("trainer value will come !");
            ret["type"] = "trainer";
            ret["data"] = data;
          }
        })
        .catch()
        .finally(() => resolve(ret));
    });
  }
  siteData(siteData) {
    let ret = { type: "default" };
    return new Promise((resolve, reject) => {
      this.db
        .run(`SELECT settings.* FROM settings WHERE settings.trainer_id = ?`, [
          siteData.id,
        ])
        .then((data) => {
          if (data.length === 0) {
            console.log("default value will come !");
            return new Promise((resolve, reject) => {
              this.db
                .run(`SELECT settings.* FROM settings WHERE settings.id = 1`)
                .then((newdata) => {
                  ret["type"] = "default";
                  ret["data"] = newdata;
                })
                .catch((err) => {})
                .finally(() => resolve(ret));
            });
          } else {
            console.log("trainer value will come !");
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
        let fname =
          ftype +
          "_" +
          _.get(data, "id", "new") +
          "_" +
          moment().unix() +
          file.name;
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
  editsiteData(data, files, user_id) {
    console.log(data);
    console.log(files);
    console.log(user_id);
    let frmdata = _.pick(data, [
      "id",
      "company_name",
      "site_title",
      "contact_phone",
      "contact_email",
      "copywrite_text",
      "contact_address",
    ]);
    frmdata["trainer_id"] = user_id;
    return this.uploadImage(data, _.get(files, "logo", false), "logo").then(
      (fname) => {
        frmdata["logo"] = fname;
        if (data.id > 0) {
          const currentDate = new Date();
          const year = currentDate.getFullYear();
          const month = String(currentDate.getMonth() + 1).padStart(2, "0");
          const day = String(currentDate.getDate()).padStart(2, "0");
          const hours = String(currentDate.getHours()).padStart(2, "0");
          const minutes = String(currentDate.getMinutes()).padStart(2, "0");
          const seconds = String(currentDate.getSeconds()).padStart(2, "0");
          const formattedDate = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
          frmdata["updated_at"] = formattedDate;
          return super.edit(frmdata, data.id);
        } else {
          return super.add(frmdata);
        }
      }
    );
  }
}

module.exports = SettingsModel;
