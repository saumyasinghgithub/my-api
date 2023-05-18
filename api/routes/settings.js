const express = require("express");
const router = express.Router();
const { routeWrapper } = require("./apiutils");
const SettingsModel = require("../models/SettingsModel");

module.exports = () => {
  router.get("/", function (req, res) {
    routeWrapper(req, res, true, (token) => new SettingsModel().getsiteData({ trainer_id: token.data.id }));
  });
  router.get("/trainer/:trainer_id", function (req, res) {
    routeWrapper(req, res, false, () => new SettingsModel().getsiteData({ trainer_id: req.params.trainer_id }));
  });
  router.post("/site-settings", function (req, res) {
    routeWrapper(req, res, false, () => new SettingsModel().siteData(req.body));
  });
  router.put("/", function (req, res, next) {
    routeWrapper(req, res, true, (token) => new SettingsModel().save(req.body, req.files, token.data.id));
  });
  return router;
};
