const express = require('express');
const router = express.Router();
const {routeWrapper} = require('./apiutils');
const CartModel = require('../models/CartModel');
const PaymentModel = require('../models/PaymentModel');
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

  router.post('/orderSuccess',(req,res) => {    
    routeWrapper(req,res, true, (token) => (new PaymentModel()).orderSuccess({...req.body,user_id: token.data.id}))
  });
  
   
  router.get('/orderSuccess/:id', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      return (new PaymentModel()).getOrdertData({id:req.params.id, user_id: token.data.id})
      .then(data => {
        return ({data, success: true});
      })
      .catch(e => ({success: false, message: e.message}))
    });
  });

  return router;
  
};