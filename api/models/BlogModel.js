const BaseModel = require('./BaseModel');

class BlogModel extends BaseModel {

  table = "blogs";
  pageLimit = 10;

}

module.exports = BlogModel;