const _ = require('lodash');
const moment = require('moment');
const bcrypt = require('bcryptjs');
const apiutils = require('./../routes/apiutils');
const BaseModel = require('./BaseModel');
const Emailer = require('./EmailModel');
const RoleModel = require('./RoleModel');

class TrainerCalib extends BaseModel {

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

}



module.exports = {TrainerCalib};