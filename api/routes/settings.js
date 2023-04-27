const express = require('express');
const router = express.Router();
const {routeWrapper} = require('./apiutils');
const SettingsModel = require('../models/SettingsModel');

module.exports = () => {
    router.get('/site-settings', function (req, res) {
        console.log('hello');
        routeWrapper(req,res, true, (token) => (new SettingsModel()).getsiteData(req.body,token.data.id))
    });
    router.post('/site-settings', function (req, res) {
        routeWrapper(req,res, false, () => (new SettingsModel()).siteData(req.body))
    });
    router.put("/add-site-settings", function (req, res, next) {
        routeWrapper(req, res, true, (token) => (new SettingsModel().editsiteData(req.body, req.files, token.data.id)));
    });
    return router;
};
