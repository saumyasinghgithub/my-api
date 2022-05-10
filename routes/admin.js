const express = require('express');
const router = express.Router();
const {routeWrapper} = require('./apiutils');
const AdminModel = require('../models/AdminModel');
const _ = require('lodash');
const res = require('express/lib/response');

module.exports = () => {

  router.post('/login', routeWrapper((req) => (new AdminModel()).checkLogin(req.body)));
  //router.post('/logout', routeWrapper((req) => (new AdminModel()).checkLogin(req.body)));

return router;
};