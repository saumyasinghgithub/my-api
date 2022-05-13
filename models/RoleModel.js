const BaseModel = require('../models/BaseModel');

class RoleModel extends BaseModel {

  table = "roles";
  pageLimit = 10;

}

module.exports = RoleModel;