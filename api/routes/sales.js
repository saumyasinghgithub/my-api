const express = require("express");
const router = express.Router();
const { routeWrapper } = require("./apiutils");
const PaymentModel = require("../models/PaymentModel");
const _ = require("lodash");

module.exports = () => {
  router.get("/list", function (req, res) {
    routeWrapper(req, res, true, (token) => new PaymentModel().sales({ ...req.query, user_id: token.data.id }));
  });
  router.get("/trainerlist", function (req, res) {
    routeWrapper(req, res, true, (token) => new PaymentModel().trainersales({ ...req.query, user_id: token.data.id }));
  });
  return router;
};
