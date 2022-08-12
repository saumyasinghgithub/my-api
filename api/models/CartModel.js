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

  getCartData({user_id}){
    let sql = `SELECT c.slug, c.name, c.price as baseprice, c.course_image, ca.* FROM cart ca
    INNER JOIN courses c ON ca.course_id = c.id  
    WHERE ca.user_id = ? AND ca.status=? 
    ORDER BY ca.id DESC`
    return this.db.run(sql,[user_id,'queue']);
  }

  delete(pkval,user_id){
    return this.find(pkval)
    .then(rec => {
      if(rec.user_id==user_id && rec.status=='queue'){
        return super.delete(pkval);
      }else{
        throw "Invalid data access!";
      }
    })
  }

  clearCart(user_id){
    return this.deleteWhere({user_id: user_id, status: 'queue'});
  }

}


module.exports = CartModel;