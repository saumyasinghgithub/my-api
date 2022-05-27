const express = require('express');
const router = express.Router();
const {routeWrapper, isTrainer} = require('./apiutils');
const TModel = require('../models/TrainerModel');
const _ = require('lodash');
const res = require('express/lib/response');

module.exports = () => {
  
  
  router.get('/my-about', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerAbout()).findBy({"fname": 'user_id', "fvalue": token.data.id})
        .then(res => ({success: true, data: res[0]}));
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/my-about', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerAbout()).edit(req.body, req.files, token.data.id);
      }else{
        throw({message: "Permission Denied!"});
      }
    });
  });
  
  router.get('/my-calibs', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerCalib()).list({'user_id': token.data.id});
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/my-calibs', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerCalib()).edit(req.body,token.data.id);
      }else{
        throw({message: "Permission Denied!"});
      }
    });
  });

  router.get('/my-academic', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerAcademic()).list({'user_id': token.data.id});
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/my-academic', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerAcademic()).edit(req.body,token.data.id);
      }else{
        throw({message: "Permission Denied!"});
      }
    });
  });


  router.get('/my-exp', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerExp()).list({'user_id': token.data.id});
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/my-exp', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerExp()).edit(req.body,token.data.id);
      }else{
        throw({message: "Permission Denied!"});
      }
    });
  });

  

  return router;
  
};