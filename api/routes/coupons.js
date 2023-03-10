const express = require('express');
const router = express.Router();
const { routeWrapper } = require('./apiutils');
const CouponsModel = require('../models/CouponsModel');
const PaymentModel = require('../models/PaymentModel');
const _ = require('lodash');
const res = require('express/lib/response');

module.exports = () => {
    router.get('/list', function (req, res) {
        console.log('entering there');
        routeWrapper(req, res, true, (token) => (new CouponsModel()).getAllCoupons({ ...req.query}).then(data => ({ success: true, data: data })));
    });
    router.delete('/:id', function (req, res, next) {
        routeWrapper(req,res, true, () => (new CouponsModel()).delete(req.params.id));  
    }); 
    return router;
}