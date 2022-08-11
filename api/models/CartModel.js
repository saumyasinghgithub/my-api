const _ = require('lodash');
const moment = require('moment');
const apiutils = require('./../routes/apiutils');
const BaseModel = require('./BaseModel');

class CartModel extends BaseModel {

  table = "cart";
  pageLimit = 10;

  add(data){
    return this.deleteWhere({user_id: data.user_id, course_id: data.course_id, status: 'queue'}).then(() => super.add(data));
  }

}

module.exports = CartModel;