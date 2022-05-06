const express = require('express');
const router = express.Router();
const {canAccess, verifyToken} = require('./apiutils');
const UserModel = require('../models/UserModel');
const path = require('path');
const _ = require('lodash');
const moment = require('moment');

module.exports = () => {

  router.post('/login', function(req,res,next){    
    canAccess(req)
    .then(() => {
      (new UserModel()).checkLogin(req.body)
      .then(rec => res.json(rec));
    })
    .catch(err => res.send("Invalid Access"));
      

  });

  router.get('/listUsers', function (req, res, next) {
    canAccess(req)
    .then(() => {
      try{
        token = verifyToken(req);
        if (token['success']) {
          new UserModel().listUsers(req.body)
          .then(rec => res.json(rec));
        } else {
          res.send(token['message']);
        }
      }
      catch (e) {
        res.send("Invalid Access UserModel in listUsers");
      }
  })
  .catch(err => res.send("Invalid Access"));
  });

  router.post('/addUser', function (req, res, next) {
    console.log("1111");
    canAccess(req)
      .then(() => {
        try {
          token = verifyToken(req);
          if (token['success']) {
            new UserModel().addUser(req.body)
              .then(rec => { console.log("then"); res.json(rec) })
              .catch(err => { res.send("User already Exists.") });

          } else {
            res.send(token['message']);
          }
        } catch (e) {
          res.send("Invalid Access UserModel in addUser")
        }
      })
      .catch(err => res.send("Invalid Access"));
  });

  router.post('/editUser', function (req, res, next) {
    canAccess(req)
      .then(() => {
        try {
          token = verifyToken(req);
          if (token['success']) {
            new UserModel().editUser(req.body)
              .then(rec => { res.json(rec) })
              .catch(err => { res.send("Failed to Update.") });
          } else {
            res.send(token['message']);
          }
        } catch (e) {
          res.send("Invalid Access UserModel in editUser")
        }
      })
      .catch(err => res.send("Invalid Access"));
  });

  router.delete('/deleteUser', function (req, res, next) {
    try{
        token = verifyToken(req);
        if(token['success']){
          new UserModel().deleteUser(req.body)
          .then(rec => res.json(rec));
        }else {
          res.send(token['message']);
        }
    }catch(e){
      res.send("Invalid Access UserModel in deleteUser")
    }
  });

  router.post('/createGroup', function (req, res, next) {
    canAccess(req)
      .then(() => {
        try {
         
          token = verifyToken(req);
          if (token['success']) {
            (new UserModel()).createGroup(req.body)
              .then(rec => { res.json(rec) })
              .catch(err => { res.json(err.sqlMessage) });

          } else {
            res.send(token['message']);
          }
        } catch (e) {
          res.send("Invalid Access UserModel in createGroup")
        }
      })
      .catch(err => res.send("Invalid Access"));
  });

  router.post('/editGroup', function (req, res, next) {
    canAccess(req)
      .then(() => {
        try {
          token = verifyToken(req);
          if (token['success']) {
            new UserModel().editGroup(req.body)
              .then(rec => { res.json(rec) })
              .catch(err => { res.send("Failed to Update.") });
          } else {
            res.send(token['message']);
          }
        } catch (e) {
          res.send("Invalid Access UserModel in editGroup")
        }
      })
      .catch(err => res.send("Invalid Access"));
  });



return router;
};