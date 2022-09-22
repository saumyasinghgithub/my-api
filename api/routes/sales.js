const express = require('express');
const router = express.Router();
const {routeWrapper} = require('./apiutils');
const CartModel = require('../models/CartModel');
const PaymentModel = require('../models/PaymentModel');
const _ = require('lodash');

module.exports = () => {
    
  router.get('/list', function (req, res) {
    routeWrapper(req,res, true, () => (new PaymentModel()).sales({...req.query}))
  });
  return router;
  
};