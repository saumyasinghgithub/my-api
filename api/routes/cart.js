const express = require('express');
const router = express.Router();
const {routeWrapper} = require('./apiutils');
const CartModel = require('../models/CartModel');
const _ = require('lodash');
const res = require('express/lib/response');

module.exports = () => {
  router.post('/',(req,res) => {    
    routeWrapper(req,res, true, (token) => (new CartModel()).add({...req.body,user_id: token.data.id}))
  });
  
  router.get('/', function (req, res) {
    routeWrapper(req,res, true, (token) => (new CartModel()).getCartData({...req.query, user_id: token.data.id}).then(data => ({success: true, data: data})));
  });

  router.delete('/empty', function (req, res, next) {
    routeWrapper(req,res, true, (token) => (new CartModel()).clearCart(token.data.id));  
  });

  router.delete('/:id', function (req, res, next) {
    routeWrapper(req,res, true, (token) => (new CartModel()).delete(req.params.id, token.data.id));  
  });

  router.post('/generateOrder',(req,res) => {    
    routeWrapper(req,res, true, (token) => (new CartModel()).generateOrder({...req.body,user_id: token.data.id}))
  });
  
 

  return router;
  
};