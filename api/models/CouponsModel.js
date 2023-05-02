const BaseModel = require('./BaseModel');
const _ = require("lodash");

class CouponsModel extends BaseModel {
  table = "trainer_coupons";
  pageLimit = 10;

  getAllCoupons() {
    let ret = { success: false };
    let sql = `SELECT trainer_coupons.*, GROUP_CONCAT(courses.name SEPARATOR ',') as items 
    FROM trainer_coupons 
    INNER JOIN courses ON FIND_IN_SET(courses.id, trainer_coupons.item_id) 
    GROUP BY trainer_coupons.id
    LIMIT 0, 25;
    `;
    console.log(sql);
    return this.db.run(sql).then((res)=>{
      ret['success'] = true;
      ret['data']=res;
      return ret;
    });
  }
}

module.exports = CouponsModel;