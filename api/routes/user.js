const express = require("express");
const router = express.Router();
const { routeWrapper } = require("./apiutils");
const UserModel = require("../models/UserModel");
const _ = require("lodash");
const MoodleAPI = require("../models/MoodleAPI");

module.exports = () => {
  router.post("/login", (req, res) => {
    routeWrapper(req, res, false, () => new UserModel().checkLogin(req.body));
  });

  router.post("/forgotpass", (req, res) => {
    routeWrapper(req, res, false, () =>
      new UserModel().forgotPassword(req.body)
    );
  });

  router.post("/resetpass", (req, res) => {
    routeWrapper(
      req,
      res,
      false,
      (vpass) => new UserModel().resetPassword({ ...req.body, vpass: vpass }),
      true
    );
  });

  router.post("/chgpwd", (req, res) => {
    routeWrapper(
      req,
      res,
      true,
      (token) =>
        new UserModel().changePassword({ ...req.body, user_id: token.data.id }),
      true
    );
  });

  router.get("/list", function (req, res) {
    routeWrapper(req, res, true, () =>
      new UserModel().list({
        ...req.query,
        fields: `id,firstname,middlename,lastname,email,mobile,registered_at,active,role_id, IF(role_id=${process.env.TRAINER_ROLE} ,(SELECT slug FROM trainer_about WHERE user_id=users.id) ,'id') as slug`,
      })
    );
  });

  router.post("/add", function (req, res, next) {
    routeWrapper(req, res, false, () =>
      new UserModel().add(
        _.pick(req.body, [
          "role",
          "firstname",
          "middlename",
          "lastname",
          "country",
          "address",
          "zipcode",
          "state",
          "mobile",
          "email",
          "password",
          "active",
        ])
      )
    );
  });

  router.put("/edit/:id", function (req, res, next) {
    routeWrapper(req, res, true, () =>
      new UserModel().edit(req.body, req.params.id)
    );
  });

  router.delete("/:id", function (req, res, next) {
    routeWrapper(req, res, true, () => new UserModel().delete(req.params.id));
  });

  router.post("/markfav", function (req, res, next) {
    routeWrapper(req, res, true, (token) =>
      new UserModel().markfav({ user_id: token.data.id, ...req.body })
    );
  });

  return router;
};
