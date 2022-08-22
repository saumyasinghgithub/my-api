const express = require('express');
const router = express.Router();
const {routeWrapper, isStudent} = require('./apiutils');
const SModel = require('../models/StudentModel');
const SEModel = require('../models/StudentEnrollmentModel');
const _ = require('lodash');
const res = require('express/lib/response');

module.exports = () => {
  
  
  router.get('/my-about', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isStudent(token.data)){
        return (new SModel.StudentAbout()).findBy({"fname": 'user_id', "fvalue": token.data.id})
        .then(res => ({success: true, data: res[0]}));
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/my-about', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isStudent(token.data)){
        return (new SModel.StudentAbout()).edit(req.body, req.files, token.data.id);
      }else{
        throw({message: "Permission Denied!"});
      }
    });
  });
  
  router.get('/my-order', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      return (new SEModel()).getEnrolledDataByID(token.data.id)
      .then(oData => {
        return ({...oData, success: true});
      })
      .catch(e => ({success: false, message: e.message}))
    })
  });


  return router;
  
};