const express = require('express');
const router = express.Router();
const { routeWrapper } = require('./apiutils');
const CouponsModel = require('../models/CouponsModel');
const CourseModel = require('../models/CourseModel');
const _ = require('lodash');
const res = require('express/lib/response');

module.exports = () => {
    router.get('/courselist', function (req, res) {
        routeWrapper(req, res, true, () => (new CourseModel()).list());
    });
    router.post('/add', function (req, res, next) {
        console.log('entering here');
        routeWrapper(req,res, true, () => (new CouponsModel()).add(req.body));
    });
    router.get('/list', function (req, res) {
        routeWrapper(req, res, true, (token) => (new CouponsModel()).getAllCoupons());
    });
    router.delete('/:id', function (req, res, next) {
        routeWrapper(req,res, true, () => (new CouponsModel()).delete(req.params.id));  
    }); 
    return router;
}