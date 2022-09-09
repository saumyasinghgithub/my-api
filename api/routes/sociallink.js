const express = require('express');
const router = express.Router();
const {routeWrapper} = require('./apiutils');
const SociallinkModel = require('../models/SociallinkModel');

module.exports = () => {

  router.get('/list', function (req, res) {
    routeWrapper(req,res, false, () => (new SociallinkModel()).list(req.query))
  });

  router.post('/add', function (req, res, next) {
    routeWrapper(req,res, true, () => (new SociallinkModel()).add(req.body));
  });

  router.put('/edit/:id', function (req, res, next) {
    routeWrapper(req,res, true, () => (new SociallinkModel()).edit(req.body,req.params.id));
  });

  router.delete('/:id', function (req, res, next) {
    routeWrapper(req,res, true, () => (new SociallinkModel()).delete(req.params.id));  
  }); 

  return router;
  
};