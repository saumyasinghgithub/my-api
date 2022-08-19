const _ = require('lodash');
const moment = require('moment');
const BaseModel = require('./BaseModel');
const CartModel = require('./CartModel');
const StudentEnrollmentModel = require('./StudentEnrollmentModel');
const Emailer = require('./EmailModel');

class PaymentModel extends BaseModel {

  table = "payments";
  pageLimit = 10;
  updated_at = true;

  orderSuccess(orderData){
    let ret = {'success': true};

    return new Promise((resolve,reject) => {
   
      if (orderData.user_id) {

        var { validatePaymentVerification } = require('razorpay/dist/utils/razorpay-utils');

        try{

          ret.success = validatePaymentVerification({
            "order_id": orderData.razorpayOrderId, 
            "payment_id": orderData.razorpayPaymentId 
          }, orderData.razorpaySignature, process.env.RAZORPAY_SECRET);


          if (ret.success) {

            this.add({
              user_id: orderData.user_id,
              payment_id: orderData.razorpayPaymentId,
              items: orderData.notes.cartItems,
              currency: orderData.currency,
              amount: orderData.amount/100,
              dump: JSON.stringify(_.pick(orderData,['name','description','razorpayOrderId'])),
              is_complete: true
            }).then(res => {
              ret.success = res.success;
              ret.message = res.success ? 'Payment processed successfully!' : 'Adding payment details failed!';
              ret.id = res.insertId;
            })
            .then(() => this.updateCartItems(JSON.parse(orderData.notes.cartItems)))
            .then(() => this.enrollStudents(orderData.user_id, JSON.parse(orderData.notes.cartItems)))
            .then(() => this.notifyPayment2User(orderData))
            .then(() => resolve(ret))
            .catch(reject);
          }
        }catch(err){
          ret['success'] = false;
          ret['message'] = err.message;
          resolve(ret);
        }
        
      } else {
          ret['success'] = false;
          ret['message'] = 'Please login to continue..';
          resolve(ret);
      }

    });
  }

  getOrdertData({id,user_id}) {
    return this.find(id)
    .then(res => res['user_id']===user_id ? res : false)
  };

  updateCartItems(cartItems){
    const cartObj = new CartModel();
    return new Promise((resolve,reject) => {
      let idx = -1;
      const updateCartItem = () => {
        if(++idx >= cartItems.length){
          resolve();
        }else{
          let ci = cartItems[idx];
          cartObj.edit({status: 'paid'},ci.id).finally(updateCartItem);
        }
      };

      updateCartItem();

    });
  }

  enrollStudents(user_id, cartItems){
    const seObj = new StudentEnrollmentModel();
    return new Promise((resolve,reject) => {
      let idx = -1;
      const enrollStudent = () => {
        if(++idx >= cartItems.length){
          resolve();
        }else{
          let ci = cartItems[idx];
          seObj.add({
            user_id: user_id, 
            course_id: ci.course,
            resources: ci.resources.join(',')
          }).finally(enrollStudent);
        }
      };

      enrollStudent();

    });
  }

  notifyPayment2User(orderData){
    var data = {};
     return Emailer.sendEmail({
      //to: data.email,
      to: "rajeshs@knowledgesynonyms.com",
      subject: `WELCOME `,
      html: this.paymentEmail({...data, user_id: orderData.user_id, payment_id: orderData.razorpayPaymentId, items:orderData.notes.cartItems, currency:orderData.currency, amount: orderData.amount/100, dump:JSON.stringify(_.pick(orderData,['name','description','razorpayOrderId'])) })
    })
    .then(data => {
      return data;
    });

  }
  
  paymentEmail(data){
    let html = `<p>Hi Umesh,</p>
    <p>Welcome to ${process.env.APP_NAME}.</p>
    <p>You can use the following credetials to <a href="${process.env.APP_URL}/login">login to your ${data.role} area</a></p>
    <p>Username: <b>email address</b></p>
    <p>Password: <b>${data.payment_id}</b></p>
    <p>Please do not share your credentials to avoid sensitive data breach.</p>
    Good Luck.<br />
    Administrator`;
    return html;

  }

}

module.exports = PaymentModel;