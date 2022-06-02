const _ = require('lodash');
const BaseModel = require('./BaseModel');
const fs = require('fs');
const path = require('path');
const e = require('cors');

class CourseModel extends BaseModel {

  table = "courses";

  getBySlug(slug){

    return new Promise((resolve,reject) => {
      resolve({title: "Test Course " + slug});
    });
    
    /*this.db.run(`SELECT * FROM ${this.table} WHERE slug=? LIMIT 1`,[slug])
    .then((res,err) => {
      console.log(res);
    })*/

  }



}

module.exports = CourseModel;