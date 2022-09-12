const express = require('express');
const router = express.Router();
const {routeWrapper} = require('./apiutils');
const BlogModel = require('../models/BlogModel');

module.exports = () => {

  router.get('/list', function (req, res) {
    routeWrapper(req,res, false, () => (new BlogModel()).list(req.query))
  });

  router.post('/add', function (req, res, next) {
    routeWrapper(req,res, true, () => (new BlogModel()).add(req.body));
  });

  router.put('/edit/:id', function (req, res, next) {
    routeWrapper(req,res, true, () => (new BlogModel()).edit(req.body,req.params.id));
  });

  router.delete('/:id', function (req, res, next) {
    routeWrapper(req,res, true, () => (new BlogModel()).delete(req.params.id));  
  }); 

  return router;
  
};