const express = require("express");
const router = express.Router();
const { routeWrapper } = require("./apiutils");
const CouponsModel = require("../models/CouponsModel");
const CourseModel = require("../models/CourseModel");
const _ = require("lodash");
const res = require("express/lib/response");

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
  return router;
};
