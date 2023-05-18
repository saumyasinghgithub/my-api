const express = require("express");
const router = express.Router();
const { routeWrapper } = require("./apiutils");
const ContactModel = require("../models/ContactModel");
const _ = require("lodash");

module.exports = () => {
  router.post("/add", function (req, res, next) {
    routeWrapper(req, res, false, () => new ContactModel().add(_.get(req, "body.slug", ""), _.pick(req.body, ["name", "phone", "email", "message"])));
  });

  router.get("/list", function (req, res) {
    routeWrapper(req, res, false, () => new ContactModel().list(req.query));
  });

  router.delete("/:id", function (req, res, next) {
    routeWrapper(req, res, true, () => new ContactModel().delete(req.params.id));
  });

  return router;
};
