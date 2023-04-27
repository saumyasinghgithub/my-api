const BaseModel = require("./BaseModel");
const _ = require("lodash");
const path = require("path");
const moment = require("moment");
const fs = require("fs");

class SettingsModel extends BaseModel {
  table = "settings";
  pageLimit = 10;

  /*siteData(siteData) {
    let ret = { type: "default" };
    let sql = `SELECT settings.* FROM settings WHERE settings.trainer_id = ? `;
    return this.db.run(sql,[siteData.id]).then((data)=>{
      if(data.length === 0){
        console.log("sorry default value will come !");
        let newsql = `SELECT settings.* FROM settings WHERE settings.id = 1`;
        console.log(newsql);
        ret['type'] = "default";
        return this.db.run(newsql).then((newres)=>{
          ret['data'] = newres;          
        });
      } else {
        console.log("trainer value will come !");
        ret['type'] = "trainer";
        ret['data'] = data[0];
        return ret;
      }
    });
  }*/
  getsiteData(siteData,user_id) {
    console.log('I am here');
    let ret = { type: "default" };
    return new Promise((resolve, reject) => {
      this.db.run(`SELECT settings.* FROM settings WHERE settings.trainer_id = ?`,[user_id])
      .then((data)=>{
        if(data.length === 0){
          console.log("default value will come !");
          return new Promise((resolve,reject)=>{
            this.db.run(`SELECT settings.* FROM settings WHERE settings.id = 1`).then((newdata)=>{
              ret['type'] = "default";
              ret['data'] = newdata;
            }).catch(err=>{}).finally(()=>resolve(ret));
          });
        } else {
          console.log("trainer value will come !");
          ret['type'] = "trainer";
          ret['data'] = data;
        }
      }).catch().finally(()=>resolve(ret));
    })
  }
  siteData(siteData) {
    let ret = { type: "default" };
    return new Promise((resolve, reject) => {
      this.db.run(`SELECT settings.* FROM settings WHERE settings.trainer_id = ?`,[siteData.id])
      .then((data)=>{
        if(data.length === 0){
          console.log("default value will come !");
          return new Promise((resolve,reject)=>{
            this.db.run(`SELECT settings.* FROM settings WHERE settings.id = 1`).then((newdata)=>{
              ret['type'] = "default";
              ret['data'] = newdata;
            }).catch(err=>{}).finally(()=>resolve(ret));
          });
        } else {
          console.log("trainer value will come !");
          ret['type'] = "trainer";
          ret['data'] = data;
        }
      }).catch().finally(()=>resolve(ret));
    })
  }
  uploadImage(data, file, ftype) {
    return new Promise((resolve, reject) => {
      if (!file) {
        resolve(_.get(data, `old_${ftype}_image`, ""));
      }
      if (_.get(file, "size", 0) > 0) {
        let fname = ftype + "_" + _.get(data, "id", "new") + "_" + moment().unix() + file.name;
        let fpath = path.resolve("public", "uploads", ftype, fname);
        file.mv(fpath, (err) => {
          if (err) {
            reject(err);
          } else {
            this.deleteImage(ftype, _.get(data, `old_${ftype}_image`, ""));
            resolve(fname);
          }
        });
      } else {
        resolve(_.get(data, `old_${ftype}_image`, ""));
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
    let frmdata = data;
    frmdata["trainer_id"] = user_id;
    return this.uploadImage(data, _.get(files, "logo", false), "logo")
      .then((fname) => {
        frmdata["logo"] = fname;
        if (data.id > 0) {
          return super.edit(frmdata, data.id);
        } else {
          return super.add(frmdata);
        }
      });
  }

}

module.exports = SettingsModel;
