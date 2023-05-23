const BaseModel = require("./BaseModel");
const _ = require("lodash");

class CouponsModel extends BaseModel {
  table = "trainer_coupons";
  pageLimit = 10;

  prepareCouponData(pdata) {
    let data = {
      ...pdata,
      course_ids: null,
      usage_limit: !_.isEmpty(pdata.usage_limit) ? pdata.usage_limit : null,
      expiry_date: !_.isEmpty(pdata.expiry_date) ? pdata.expiry_date : null,
    };

    if (!_.isEmpty(pdata.course_ids)) {
      data.course_ids = _.isArray(pdata.course_ids) ? pdata.course_ids.map((c) => parseInt(c)).join(",") : pdata.course_ids;
    }

    return data;
  }

  add(data) {
    return super.add(this.prepareCouponData(data));
  }

  edit(pdata, pkval = "") {
    return super.edit(this.prepareCouponData(pdata), pkval);
  }

  getAllCoupons(trainer_id) {
    let ret = { success: false };
    let sql = `SELECT trainer_coupons.*, (SELECT GROUP_CONCAT(courses.name SEPARATOR ',') FROM courses WHERE FIND_IN_SET(courses.id, trainer_coupons.course_ids)) as courses 
    FROM trainer_coupons 
    WHERE trainer_coupons.trainer_id=${trainer_id}
    GROUP BY trainer_coupons.id`;
    return this.db.run(sql).then((res) => {
      ret["success"] = true;
      ret["data"] = res;
      return ret;
    });
  }
}

module.exports = CouponsModel;
