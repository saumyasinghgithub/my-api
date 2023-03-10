const _ = require('lodash');
const moment = require('moment');
const BaseModel = require('./BaseModel');

const Razorpay = require('razorpay');

class CouponsModel extends BaseModel {
    table = "coupons";
    pageLimit = 10;
    updated_at = true;

    getAllCoupons(){
        console.log('entering here');
        let sql = `SELECT id,coupon_code, discount,discription,DATE_FORMAT(expiry_date, '%Y-%m-%d') as expiry_date FROM coupons`
        return this.db.run(sql);
      }
}

module.exports = CouponsModel;