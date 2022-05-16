const BaseModel = require('./BaseModel');

class RoleModel extends BaseModel {

  table = "roles";
  pageLimit = 10;

}

module.exports = RoleModel;