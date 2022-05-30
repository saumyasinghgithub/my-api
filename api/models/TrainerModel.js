const _ = require('lodash');
const BaseModel = require('./BaseModel');
const fs = require('fs');
const path = require('path');
const e = require('cors');

class TrainerBase extends BaseModel {

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
      if(_.get(file,'size',0) > 0){
        let fname = ftype + '_' + data.id + '_' + file.name;
        let fpath = path.resolve('public','uploads',ftype,fname);
        file.mv(fpath, err => {
          if(err){
            reject(err);
          }else{
            this.deleteImage(ftype,`data.old_${ftype}_image`);
            resolve(fname);
          }
        })
      }else{
        resolve(`data.old_${ftype}_image`);
      }
    })
  }

}

class TrainerCalib extends TrainerBase {

  table = "trainer_calibrations";
  pageLimit = 10;
  
  edit(data,user_id){

    let iData = [];
    
    const getpa_id =(k) => k.substring(6,k.indexOf(']'));

    _.each(data, (v,k) => {
      if(_.isArray(v)){
        _.each(v, v1 => iData.push({
          'user_id': user_id,
          'pa_id': getpa_id(k),
          'pa_value': v1
        }));
      }else{
        iData.push({
          'user_id': user_id,
          'pa_id': getpa_id(k),
          'pa_value': v
        });
      }
    });

    return this.deleteWhere({'user_id': user_id})
    .then(res => this.addMulti(iData))
    .then(data => ({
      success: true,
      message: 'Data saved!'
    }));
    
  }

  
}

class TrainerAcademic extends TrainerBase {

  table = "trainer_academic";

  edit(data,user_id){

    let iData = [];

    _.each(data.year, (v,k) => {
      if(v!=='' && data.qualification[k]!=''){
        iData.push({
          'user_id': user_id,
          'qualification': data.qualification[k],
          'year': v
        });
      }
      
    });

    return this.deleteWhere({'user_id': user_id})
    .then(res => this.addMulti(iData))
    .then(data => ({
      success: true,
      message: 'Data saved!'
    }));
    
  }
}

class TrainerExp extends TrainerBase {

  table = "trainer_exp";

  edit(data,user_id){
    let iData = [];

    _.each(data.location, (v,k) => {
      if(v!=='' && data.company[k]!=''){
        iData.push({
          'user_id': user_id,
          'company': data.company[k],
          'location': v
        });
      }
      
    });

    console.log(iData);

    return this.deleteWhere({'user_id': user_id})
    .then(res => this.addMulti(iData))
    .then(data => ({
      success: true,
      message: 'Data saved!'
    }));
    
  }

}

class TrainerAbout extends TrainerBase {

  table = "trainer_about";

  

  edit(data,files,user_id){
    
    let frmdata = _.pick(data,['firstname','middlename','lastname','biography','certificates','trainings']);
    frmdata['user_id'] = user_id;
    return this.uploadImage(data, files.profile_image,'profile')
    .then(fname => {
      frmdata['profile_image'] = fname;
      return this.uploadImage(data, files.award_image, 'award');
    })
    .then(fname => {
      frmdata['award_image'] = fname;
      if(data.id > 0){
        return super.edit(frmdata, data.id);
      }else{
        return super.add(frmdata);
      }
    });

  }
}

class TrainerServices extends TrainerBase {

  table = "trainer_services";

  edit(data,files,user_id){
    
    let frmdata = _.pick(data,['service_offer','consultancy','coaching']);
    frmdata['user_id'] = user_id;
    return this.uploadImage(data, files.service_image,'service')
    .then(fname => {
      frmdata['service_image'] = fname;
      if(parseInt(data.id) > 0){
        return super.edit(frmdata, data.id);
      }else{
        return super.add(frmdata);
      }
    });

  }
}

module.exports = {TrainerCalib, TrainerAcademic, TrainerExp, TrainerAbout, TrainerServices};