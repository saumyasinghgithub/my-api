const express = require("express");
const router = express.Router();
const { routeWrapper } = require("./apiutils");
const CouponsModel = require("../models/CouponsModel");
const _ = require("lodash");
const moment = require("moment");

module.exports = () => {
  router.post("/", function (req, res, next) {
    routeWrapper(req, res, true, (token) => new CouponsModel().add({ ...req.body, trainer_id: token.data.id }));
  });
  router.put("/:id", function (req, res, next) {
    routeWrapper(req, res, true, (token) => new CouponsModel().edit({ ...req.body }, req.params.id));
  });
  router.get("/edit/:id", function (req, res, next) {
    routeWrapper(req, res, true, (token) => new CouponsModel().find(req.params.id).then((data) => ({ success: true, data: data })));
  });
  router.get("/list", function (req, res) {
    routeWrapper(req, res, true, (token) => new CouponsModel().getAllCoupons(token.data.id));
  });
  router.delete("/:id", function (req, res, next) {
    routeWrapper(req, res, true, () => new CouponsModel().delete(req.params.id));
  });

  router.post("/fetch", function (req, res, next) {
    routeWrapper(req, res, true, (token) =>
      new CouponsModel()
        .list({
          whereStr: `coupon_code='${req.body.coupon}'`,
          limit: 1,
        })
        .then((res) => {
          if (res.success && res.data.length === 1) {
            if (
              !_.isEmpty(res.data[0].expiry_date) &&
              res.data[0].expiry_date !== "0000-00-00" &&
              moment(res.data[0].expiry_date).isBefore(moment())
            ) {
              return { success: false, message: "Coupon code expired" };
            }

            if (res.data[0].usage_limit) {
              return new CouponsModel().db
                .run(`SELECT count(1) as total FROM payments WHERE is_complete=1 AND user_id=${token.data.id} AND coupon_id=${res.data[0].id}`)
                .then((pyt) => {
                  let alreadyUsed = parseInt(_.get(pyt, "0.total", 0));
                  if (alreadyUsed < parseInt(res.data[0].usage_limit)) {
                    return { success: true, data: res.data[0] };
                  } else {
                    return { success: false, message: "Coupon exhausted!" };
                  }
                });
            } else {
              return { success: true, data: res.data[0] };
            }
          } else {
            return { success: false, message: "Invalid Coupon code!" };
          }
        })
    );
  });

  return router;
};
