const BaseModel = require("./BaseModel");
const _ = require("lodash");

class CouponsModel extends BaseModel {
  table = "trainer_coupons";
  pageLimit = 10;

  add(data) {
    data.course_ids = _.isArray(data.course_ids) ? data.course_ids.map((c) => parseInt(c)).join(",") : data.course_ids;
    return super.add(data);
  }

  edit(data, pkval = "") {
    data.course_ids = _.isArray(data.course_ids) ? data.course_ids.map((c) => parseInt(c)).join(",") : data.course_ids;
    return super.edit(data, pkval);
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
