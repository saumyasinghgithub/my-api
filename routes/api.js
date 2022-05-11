const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const _ = require('lodash');
const PAModel = require('./../models/PAModel');

const {canAccess, routeWrapper} = require('./apiutils');

module.exports = function() {

  router.get('/genapikey',function(req,res){    
    res.send(bcrypt.hashSync(process.env.JWTSECRET, 8));
  });

  router.get('/genpwd/:pwd',function(req,res){    
    res.send(bcrypt.hashSync(req.params.pwd, 8));
  });

  router.get('/profile_fields',(req, res) => {
    routeWrapper(req,res, false, () => (new PAModel()).list(req.query))
  })

  router.get('/', (req,res,next) => {
    if(canAccess(req)){
      res.send("Welcome to API");
    }else{
      res.send("Invalid Access");
    }
  })



  return router;
}