const express = require('express');
const router = express.Router();
const {canAccess, verifyToken} = require('./apiutils');
const UserModel = require('../models/UserModel');
const path = require('path');
const _ = require('lodash');
const moment = require('moment');

module.exports = () => {

  router.post('/login', (req,res) => {    
    routeWrapper(req,res, false, () => (new UserModel()).checkLogin(req.body))
  });

  router.get('/list', function (req, res) {
    routeWrapper(req,res, true, () => (new UserModel()).list(req.query))
  });

  router.post('/add', function (req, res, next) {
    routeWrapper(req,res, true, () => (new UserModel()).add(req.body));
  });

  router.put('/edit/:id', function (req, res, next) {
    routeWrapper(req,res, true, () => (new UserModel()).edit(req.body,req.params.id));
  });

  router.delete('/:id', function (req, res, next) {
    routeWrapper(req,res, true, () => (new UserModel()).delete(req.params.id));  
  }); 


return router;
};