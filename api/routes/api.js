const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const _ = require('lodash');
const PAModel = require('./../models/PAModel');
const CourseModel = require('./../models/CourseModel');

const {canAccess, routeWrapper} = require('./apiutils');

module.exports = function() {

  router.get('/genapikey',function(req,res){    
    res.send(bcrypt.hashSync(process.env.JWTSECRET, 8));
  });

  router.get('/genpwd/:pwd',function(req,res){    
    res.send(bcrypt.hashSync(req.params.pwd, 8));
  });

  router.get('/profile_attributes',(req, res) => {
    routeWrapper(req,res, false, () => (new PAModel()).list(req.query))
  })
/*
  router.get('/course/:slug',(req, res) => {
    routeWrapper(req,res, false, () => (new CourseModel()).getBySlug(req.params.slug).then(res => ({success: true, data: res})))
  })
*/
  router.get('/course/:slug', function (req, res) {
    routeWrapper(req,res, false, () => {
      return (new CourseModel()).getBySlug(req.params)
      .then(cData => ({...cData, success: true}))
      .catch(e => ({success: false, message: e.message}))
    })
  });

  router.get('/courses',(req, res) => {
    routeWrapper(req,res, false, () => (new CourseModel()).list(req.query))
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