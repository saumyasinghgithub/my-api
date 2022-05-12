const express = require('express');
const router = express.Router();
const {canAccess, verifyToken} = require('./apiutils');
const RoleModel = require('../models/RoleModel');
const path = require('path');
const _ = require('lodash');
const moment = require('moment');

module.exports = () => {

  router.post('/login', (req,res) => {    
    routeWrapper(req,res, false, () => (new RoleModel()).checkLogin(req.body))
  });

  router.get('/list', function (req, res) {
    routeWrapper(req,res, true, () => (new RoleModel()).list(req.query))
  });

  router.post('/add', function (req, res, next) {
    routeWrapper(req,res, true, () => (new RoleModel()).add(req.body));
  });

  router.put('/edit/:id', function (req, res, next) {
    routeWrapper(req,res, true, () => (new RoleModel()).edit(req.body,req.params.id));
  });

  router.delete('/:id', function (req, res, next) {
    routeWrapper(req,res, true, () => (new RoleModel()).delete(req.params.id));  
  }); 


return router;
};