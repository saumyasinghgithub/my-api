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
        let whereParams = {'where' : {'user_id': token.data.id},'limit': 99999};
        return (new TModel.TrainerAward()).list(whereParams);
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
        return (new TModel.TrainerCalib()).list({...req.query,'user_id': token.data.id});
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
        let whereParams = {'where' : {'user_id': token.data.id},'limit': 99999};
        return (new TModel.TrainerAcademic()).list(whereParams);
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
        let whereParams = {'where' : {'user_id': token.data.id},'limit': 99999};
        return (new TModel.TrainerExp()).list(whereParams);
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
       let params = req.query;
       _.set(params, 'where.user_id',token.data.id);
        return (new TModel.TrainerCourse()).list(params)
          .then(res => ({...res, data: _.get(req,'query.where.id',null) ? res.data[0] : res.data }));
        
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

  router.get('/profile/:tid', function (req, res) {
    routeWrapper(req,res, false, () => {
      let tData = {};
      let whereParams = {'where' : {'user_id': req.params.tid},'limit': 99999};
      return (new TModel.TrainerAbout()).list(whereParams)
      .then(({data}) => {
        tData.about=_.get(data,'0',{});
        if(_.get(tData,'about.id',false)){
          return (new TModel.TrainerAward()).list(whereParams);
        }else{
          throw {message: "No such trainer found"};
        }
      })
      .then(({data}) => {
        tData.awards = data;
        return (new TModel.TrainerCalib()).list(whereParams);
      })
      .then(({data}) => {
        tData.calibs = data;
        return (new TModel.TrainerAcademic()).list(whereParams);
      })
      .then(({data}) => {
        tData.academics = data;
        return tData;
      });
    })
  });

router.get('/search', function (req, res){
  routeWrapper(req,res, false, () => {

  })
});

  return router;
  
};