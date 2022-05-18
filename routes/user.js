const express = require('express');
const router = express.Router();
const {routeWrapper} = require('./apiutils');
const UserModel = require('../models/UserModel');
const _ = require('lodash');
const res = require('express/lib/response');

module.exports = () => {
  router.post('/login',(req,res) => {    
    routeWrapper(req,res, false, () => (new UserModel()).checkLogin(req.body))
  });
  
  router.get('/list', function (req, res) {
    routeWrapper(req,res, true, () => (new UserModel()).list(req.query))
  });

  router.post('/add', function (req, res, next) {
    routeWrapper(req,res, false, () => (new UserModel()).add(_.pick(req.body,["role","firstname","middlename","lastname","country","address","zipcode","state","mobile","email","password","active"])));
  });

  router.put('/edit/:id', function (req, res, next) {
    routeWrapper(req,res, true, () => (new UserModel()).edit(req.body,req.params.id));
  });

  router.delete('/:id', function (req, res, next) {
    routeWrapper(req,res, true, () => (new UserModel()).delete(req.params.id));  
  }); 

  return router;
  
};