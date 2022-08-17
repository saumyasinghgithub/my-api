const _ = require('lodash');
const moment = require('moment');
const apiutils = require('./../routes/apiutils');
const BaseModel = require('./BaseModel');

const Razorpay = require('razorpay');

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

  generateOrder({action,user_id}){

    let rPay = new Razorpay({
      key_id: process.env.RAZORPAY_KEY,
      key_secret: process.env.RAZORPAY_SECRET,
    });

    return this.getCartData({user_id: user_id})
    .then(data => {

      let order = {
        "amount": parseInt(_.sum(data.map(d => d.price))),
        "currency": process.env.RAZORPAY_CURRENCY,
        "receipt": `AD#${user_id}-${moment().format('YYYYMMDDHHmmss')}`,
        "notes": {}
      };

      data.forEach(d => {
        let cres = JSON.parse(d.course_resources);
        order.notes[`course_${d.course_id}_${d.id}`] = d.name + '||' + cres.map(cr => cr.type).join('||');
      });

      return rPay.orders.create(order);
    })
    .then(orderData => {
      return {
        success: true, 
        data: {
          'key': process.env.RAZORPAY_KEY,
          'currency': orderData.currency,
          'amount': orderData.amount,
          'name': `Bundle Course - ${Object.values(orderData.notes).length}`,
          'description': Object.values(orderData.notes).join(' AND '),
          'notes': orderData.notes,
          'order_id': orderData.id
        }
      };
    })
  }

}


module.exports = CartModel;