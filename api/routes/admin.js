const express = require('express');
const router = express.Router();
const {routeWrapper} = require('./apiutils');
const {AdminModel, AdminDashboard} = require('../models/AdminModel');
const _ = require('lodash');
const res = require('express/lib/response');

module.exports = () => {
  router.post('/login',(req,res) => {    
    routeWrapper(req,res, false, () => (new AdminModel()).checkLogin(req.body))
  });
  
  router.get('/list', function (req, res) {
    routeWrapper(req,res, true, () => (new AdminModel()).list(req.query))
  });

  router.post('/add', function (req, res, next) {
    routeWrapper(req,res, true, () => (new AdminModel()).add(_.pick(req.body,['username','email','password'])));
  });

  router.put('/edit/:id', function (req, res, next) {
    routeWrapper(req,res, true, () => (new AdminModel()).edit(req.body,req.params.id));
  });

  router.delete('/:id', function (req, res, next) {
    routeWrapper(req,res, true, () => (new AdminModel()).delete(req.params.id));  
  }); 
 
  router.get('/stats', function (req, res) {
    routeWrapper(req,res, true, () => (new AdminDashboard()).dashboardStats())
  });

  return router;
  
};