const express = require('express');
const router = express.Router();
const {routeWrapper} = require('./apiutils');
const SettingsModel = require('../models/SettingsModel');

module.exports = () => {
    router.post('/site-settings', function (req, res) {
        routeWrapper(req,res, false, () => (new SettingsModel()).siteData(req.body))
    });
    return router;
};
