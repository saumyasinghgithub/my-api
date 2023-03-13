const BaseModel = require('./BaseModel');

class CouponsModel extends BaseModel {
  table = "trainer_coupons";
  pageLimit = 10;
  updated_at = true;

  getAllCoupons() {
    let sql = `SELECT id,coupon_code, DATE_FORMAT(expiry_date, '%Y-%m-%d') as expiry_date FROM trainer_coupons`
    return this.db.run(sql);
  }
}

module.exports = CouponsModel;