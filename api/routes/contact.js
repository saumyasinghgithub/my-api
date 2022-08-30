const express = require('express');
const router = express.Router();
const {routeWrapper} = require('./apiutils');
const ContactModel = require('../models/ContactModel');
const _ = require('lodash');


module.exports = () => {

 

  router.post('/add', function (req, res, next) {
    routeWrapper(req,res, false, () => (new ContactModel()).add(req.body));
  });

  return router;
  
};