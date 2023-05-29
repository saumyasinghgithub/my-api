const _ = require("lodash");
const moment = require("moment");
const BaseModel = require("./BaseModel");
const CouponsModel = require("./CouponsModel");
const Razorpay = require("razorpay");

class PaymentGatewayModel extends BaseModel {
  table = "payment_gateways";
  pageLimit = 10;
  updated_at = true;
}

module.exports = PaymentGatewayModel;
