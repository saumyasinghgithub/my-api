const express = require('express');
const router = express.Router();
const {routeWrapper} = require('./apiutils');
const CartModel = require('../models/CartModel');
const _ = require('lodash');

module.exports = () => {
    
  router.get('/list', function (req, res) {
    routeWrapper(req,res, true, () => (new CartModel()).sales({...req.query}))
  });
  router.get('/userlist', function (req, res) {
    routeWrapper(req,res, false, () => (new CartModel()).salesUserList(req.query))
  });
  return router;
  
};