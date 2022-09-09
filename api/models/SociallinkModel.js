const BaseModel = require('./BaseModel');

class SociallinkModel extends BaseModel {

  table = "sociallinks";
  pageLimit = 10;

}

module.exports = SociallinkModel;