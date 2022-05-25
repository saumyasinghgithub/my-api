const express = require('express');
const router = express.Router();
const {routeWrapper, isTrainer} = require('./apiutils');
const TModel = require('../models/TrainerModel');
const _ = require('lodash');
const res = require('express/lib/response');

module.exports = () => {
  
  router.get('/my-calibs', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerCalib()).list({'user_id': token.data.id});
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/calibs', function (req, res, next) {
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

  

  return router;
  
};