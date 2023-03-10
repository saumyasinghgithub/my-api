const express = require("express");
const router = express.Router();
const { routeWrapper, isTrainer } = require("./apiutils");
const CGModel = require("../models/CorporateGroupModel");
const _ = require("lodash");

module.exports = () => {
  router.get("/my-corporates", function (req, res) {
    routeWrapper(req, res, true, (token) => {
      if (isTrainer(token.data)) {
        return new CGModel().fetchStats(token.data.id);
      } else {
        throw { message: "Permission Denied!" };
      }
    });
  });

  router.put("/my-corporate", function (req, res, next) {
    routeWrapper(req, res, true, (token) => {
      if (isTrainer(token.data)) {
        if (parseInt(req.body.id) > 0) {
          return new CGModel().edit({ ...req.body, trainer_id: token.data.id });
        } else {
          return new CGModel().add({ ...req.body, trainer_id: token.data.id });
        }
      } else {
        throw { message: "Permission Denied!" };
      }
    });
  });

  router.get("/:id", function (req, res) {
    routeWrapper(req, res, true, (token) => {
      if (isTrainer(token.data)) {
        return new CGModel().fetchDetail(req.params.id, token.data.id);
      } else {
        throw { message: "Permission Denied!" };
      }
    });
  });

  router.delete("/my-corporate/:id", function (req, res, next) {
    routeWrapper(req, res, true, (token) => {
      if (isTrainer(token.data)) {
        return new TModel.TrainerBlog().delete(req.params.id);
      } else {
        throw { message: "Permission Denied!" };
      }
    });
  });

  router.put("/import", function (req, res) {
    routeWrapper(req, res, true, (token) => {
      if (isTrainer(token.data)) {
        return new CGModel().import(req.body.cg_id, req.files.csv);
      } else {
        throw { message: "Permission Denied!" };
      }
    });
  });

  router.get("/import-students", function (req, res) {
    new CGModel()
      .processRecords(10)
      .catch((err) => ({ success: false, message: err.message }))
      .then((obj) => res.send(obj.message));
  });

  router.post("/assign", function (req, res, next) {
    routeWrapper(req, res, true, (token) => {
      if (isTrainer(token.data)) {
        return new CGModel().assign({ ...req.body, trainer_id: token.data.id });
      } else {
        throw { message: "Permission Denied!" };
      }
    });
  });

  return router;
};
