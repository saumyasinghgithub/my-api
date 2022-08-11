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

  getCartData(data){
    console.log(data);
    SqlQuery = `SELECT IF(ca.user_id = ?, c.name, c.slug)slug, c.name, ca.* FROM cart ca
    LEFT JOIN courses c ON ca.course_id = c.id  
    WHERE ca.user_id = ?`
    return this.list(SqlQuery)
    .then(res =>{
      console.log(res);
    })
  }

}


module.exports = CartModel;