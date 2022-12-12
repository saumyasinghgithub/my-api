const _ = require('lodash');
const BaseModel = require('./BaseModel');
const fs = require('fs');
const path = require('path');
const slugify = require('slugify');
const PAModel = require('./PAModel');
const moment = require('moment');

class StudentBase extends BaseModel {

  addMulti(data){
    return new Promise((resolve,reject) => {
      let idx = 0;
      const addMe = () => {
        if(idx >= data.length){
          resolve(idx);
        }else{
          this.add(data[idx++])
          .then(res => {
            if(res.success){
              addMe();
            }else{
              reject(res);
            }
          })
          .catch(reject);
        }
      }

      if(data.length==0){
        resolve(0);
      }else{
        addMe();
      }

    });
  }

  deleteImage(folder,fname){
    let fpath = path.resolve('public','uploads',folder,fname);
    if(!_.isEmpty(fname) && fs.existsSync(fpath)){
      fs.unlinkSync(fpath);
    }
  }

  uploadImage(data, file,ftype){
    return new Promise((resolve,reject) => {
      if(!file){
        resolve(_.get(data,`old_${ftype}_image`,'')); 
      }
      if(_.get(file,'size',0) > 0){
        let fname = ftype + '_' + data.id + '_' +moment().unix()+ file.name;
        let fpath = path.resolve('public','uploads', 'student',ftype,fname);
        file.mv(fpath, err => {
          if(err){
            reject(err);
          }else{
            this.deleteImage(ftype,_.get(data,`old_${ftype}_image`,''));
            resolve(fname);
          }
        })
      }else{
        resolve(_.get(data,`old_${ftype}_image`,''));
      }
    })
  }

}


class StudentAbout extends StudentBase {

  table = "student_about";

  

  edit(data,files,user_id){
    
    let frmdata = _.pick(data,['firstname','middlename','lastname','slug','industry','qualification','interested_field','country','linkedin','facebook','youtube','twitter','biography']);
    frmdata['user_id'] = user_id;
    const spath = frmdata.firstname + ' ' + frmdata.lastname + ' ' + user_id;
    frmdata['slug'] = slugify(spath,{remove: /[*#+~.()'"!:@]/g, lower: true});
    return this.uploadImage(data, _.get(files,'profile_image',false),'profile')
    .then(fname => {
      frmdata['profile_image'] = fname;
      return this.uploadImage(data, _.get(files,'base_image',false), 'base');
    })
    .then(fname => {
      frmdata['base_image'] = fname;
      if(data.id > 0){
        return super.edit(frmdata, data.id);
      }else{
        return super.add(frmdata);
      }
    });

  }

}



module.exports = {StudentAbout};