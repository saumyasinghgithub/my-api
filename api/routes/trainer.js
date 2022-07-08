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

  router.get('/my-awards', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerAward()).list({'user_id': token.data.id});
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/my-awards', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerAward()).edit(req.body,token.data.id);
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

  router.get('/my-services', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerServices()).findBy({"fname": 'user_id', "fvalue": token.data.id})
        .then(res => ({success: true, data: res[0]}));
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/my-services', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerServices()).edit(req.body, req.files, token.data.id);
      }else{
        throw({message: "Permission Denied!"});
      }
    });
  });

  router.get('/my-courses', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        
        let where = {"fname": 'user_id', "fvalue": token.data.id};

        if(_.get(req,'query.id',null)){
          where['fname'] = 'id';
          where['fvalue'] = req.query.id;
        }
        return (new TModel.TrainerCourse()).findBy(where)
          .then(res => ({success: true, data: _.get(req,'query.id',null) ? res[0] : res }));
        
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/my-courses', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerCourse()).edit(req.body, req.files, token.data.id);
      }else{
        throw({message: "Permission Denied!"});
      }
    });
  });

  router.delete('/my-courses/:id', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerCourse()).delete(req.params.id);  
      }else{
        throw({message: "Permission Denied!"});
      }
    }); 
  });

  router.get('/course-content', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerCourseContent()).findBy(_.pick(req.query,['fname','fvalue']))
        .then(res => ({success: true, data: res}));
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/course-content', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerCourseContent()).edit(req.body, req.files, token.data.id);
      }else{
        throw({message: "Permission Denied!"});
      }
    });
  });

  router.delete('/course-content/:id', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerCourseContent()).delete(req.params.id);  
      }else{
        throw({message: "Permission Denied!"});
      }
    }); 
  });

  router.get('/course-resources', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerCourseResource()).findBy(_.pick(req.query,['fname','fvalue']))
        .then(res => ({success: true, data: res}));
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/course-resources', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerCourseResource()).edit(req.body);
      }else{
        throw({message: "Permission Denied!"});
      }
    });
  });

  router.delete('/course-resources/:id', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerCourseResource()).delete(req.params.id);  
      }else{
        throw({message: "Permission Denied!"});
      }
    }); 
  });


  return router;
  
};