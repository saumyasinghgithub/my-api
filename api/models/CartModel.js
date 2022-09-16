const _ = require('lodash');
const moment = require('moment');
const BaseModel = require('./BaseModel');

const Razorpay = require('razorpay');

class CartModel extends BaseModel {

  table = "cart";
  pageLimit = 10;
  updated_at = true;

  add(data){
    return this.deleteWhere({user_id: data.user_id, course_id: data.course_id, status: 'queue'}).then(() => super.add(data));
  }

  getCartData({user_id}){
    let sql = `SELECT c.slug, c.name, c.course_image, ca.* FROM cart ca
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
        "amount": parseInt(_.sum(data.map(d => d.price))) * 100, // cents to USD 
        "currency": process.env.RAZORPAY_CURRENCY,
        "receipt": `AD#${user_id}-${moment().format('YYYYMMDDHHmmss')}`,
        "notes": {}
      };

      let cartItems = [];

      data.forEach(d => {
        let cres = JSON.parse(d.course_resources);
        cartItems.push({id: d.id, course: parseInt(d.course_id), resources: cres.map(cr => cr.id)});
        order.notes[`cart_${d.id}`] = d.name + '||' + cres.map(cr => cr.type).join('||');
      });

      order.notes['cartItems'] = JSON.stringify(cartItems);

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
          'description': Object.values(_.omit(orderData.notes,['cartItems'])).join(' AND '),
          'notes': orderData.notes,
          'order_id': orderData.id
        }
      };
    })
  }

  sales(params){
    let refine = '';
    let ary = [];   

    if(_.get(params,'where',false)){
      refine += ' AND cart.user_id=?';
      console.log(params.where.user_id);
      ary.push(parseInt(_.get(params, 'user_id', params.where.user_id)));
    }

    let ret = { success: false };
    let sqlQuery = `SELECT cart.id, cart.user_id, cart.price, courses.name as course_name, CONCAT(users.firstname," ",users.middlename," ",users.lastname) AS fullname, users.firstname, users.middlename, users.lastname, cart.course_resources FROM cart
    RIGHT JOIN courses ON cart.course_id = courses.id
    RIGHT JOIN users ON cart.user_id = users.id
    where cart.status = 'paid'`;

    refine += ' LIMIT ?,?';
    ary.push(parseInt(_.get(params, 'start', 0)));
    ary.push(parseInt(_.get(params, 'limit', this.pageLimit))); 

    return this.db.run(`SELECT COUNT(cart.id) as total, cart.id, cart.user_id, cart.price, courses.name as course_name, CONCAT(users.firstname," ",users.middlename," ",users.lastname) AS fullname, users.firstname, users.middlename, users.lastname, cart.course_resources FROM cart
    RIGHT JOIN courses ON cart.course_id = courses.id
    RIGHT JOIN users ON cart.user_id = users.id
    where cart.status = 'paid'`)
      .then(ress => {
        if (ress) { 
          ret['pageInfo'] = {
            hasMore: (ress[0].total - parseInt(_.get(params,'start',0))) > parseInt(_.get(params,'limit',this.pageLimit)),
            total: ress[0].total
          };     
          ret['success'] = true;
          ret['message'] = 'list of data';
          ret['data'] = ress;
        } else {
          ret['error'] = 'No data found';
        }
        return ret;        
      })
      .then(() => {        
        return this.db.run(sqlQuery + refine, ary);
      })
      .then(res => {
        if (res) {
          ret['success'] = true;
          ret['data'] = res;
        } else {
          ret['error'] = 'No data found';
        }
        return ret;
      });
  }

  salesUserList(){ 
    return this.db.run('call getDistinctCartUsers()')
    .then(res => {
      return {success: true, data: res[0]};
    });
  }
}


module.exports = CartModel;