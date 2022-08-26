const _ = require('lodash');
const moment = require('moment');
const apiutils = require('../routes/apiutils');
const BaseModel = require('./BaseModel');

class PAModel extends BaseModel {

  table = "profile_attributes";
  pageLimit = 99999999999999; //=== Show all

  list(params){
    return super.list().then(res => {
      if(res.success && res.data.length > 0){
        res.data = res.data.map(rec => _.pick(rec,["id","title","parent_id"]));
        let data = _.filter(res.data,rec => rec.parent_id===0);
        _.each(data, (d,i) => data[i]['children'] = _.filter(res.data,rec => rec.parent_id===d.id));
        res.data = data;
      }
      return res;
    });
  }



  

}

module.exports = PAModel;