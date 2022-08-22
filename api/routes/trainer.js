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
        return (new TModel.TrainerCalib()).list({...req.query,where:{'user_id': token.data.id}});
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

  router.get('/my-knowledge', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerKnowledge()).findBy({"fname": 'user_id', "fvalue": token.data.id})
        .then(res => ({success: true, data: res[0]}));
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/my-knowledge', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerKnowledge()).edit(req.body, req.files, token.data.id);
      }else{
        throw({message: "Permission Denied!"});
      }
    });
  });

  router.get('/my-community', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerCommunity()).findBy({"fname": 'user_id', "fvalue": token.data.id})
        .then(res => ({success: true, data: res[0]}));
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/my-community', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerCommunity()).edit(req.body, req.files, token.data.id);
      }else{
        throw({message: "Permission Denied!"});
      }
    });
  });

  router.get('/my-library', function (req, res) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerLibrary()).findBy({"fname": 'user_id', "fvalue": token.data.id})
        .then(res => ({success: true, data: res[0]}));
      }else{
        throw({message: "Permission Denied!"});
      }
    })
  });

  router.put('/my-library', function (req, res, next) {
    routeWrapper(req,res, true, (token) => {
      if(isTrainer(token.data)){
        return (new TModel.TrainerLibrary()).edit(req.body, req.files, token.data.id);
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

  router.get('/profile/:slug', function (req, res) {
    routeWrapper(req,res, false, () => {
      return (new TModel.TrainerSearch()).profile(req.params)
      .then(tData => ({...tData, success: true}))
      .catch(e => ({success: false, message: e.message}))
    })
  });

router.get('/search', function (req, res){
  routeWrapper(req,res, false, () => {
      return (new TModel.TrainerSearch()).search(req.query);
  })
});

router.get('/:slug/courses', function (req, res) {
  routeWrapper(req,res, false, () => {
    return (new TModel.TrainerCourse()).bySlug(req.params.slug)
    .then(tData => {
      return ({...tData, success: true});
    })
    .catch(e => ({success: false, message: e.message}))
  })
});

router.get('/my-blogs', function (req, res) {
  routeWrapper(req,res, true, (token) => {
    if(isTrainer(token.data)){
     let params = req.query;
     _.set(params, 'where.user_id',token.data.id);
      return (new TModel.TrainerBlog()).list(params)
        .then(res => ({...res, data: _.get(req,'query.where.id',null) ? res.data[0] : res.data }));
      
    }else{
      throw({message: "Permission Denied!"});
    }
  })
});

router.put('/my-blogs', function (req, res, next) {
  routeWrapper(req,res, true, (token) => {
    if(isTrainer(token.data)){
      return (new TModel.TrainerBlog()).edit(req.body, req.files, token.data.id);
    }else{
      throw({message: "Permission Denied!"});
    }
  });
});

router.delete('/my-blogs/:id', function (req, res, next) {
  routeWrapper(req,res, true, (token) => {
    if(isTrainer(token.data)){
      return (new TModel.TrainerBlog()).delete(req.params.id);  
    }else{
      throw({message: "Permission Denied!"});
    }
  }); 
});

router.get('/my-sales-stats', function (req, res, next) {
  routeWrapper(req,res, true, (token) => {
    if(isTrainer(token.data)){
      return (new TModel.TrainerCourse()).loadStats(token.data.id);  
    }else{
      throw({message: "Permission Denied!"});
    }
  }); 
});

  return router;
  
};