const _ = require('lodash');
const BaseModel = require('./BaseModel');

class StudentEnrollmentModel extends BaseModel {

  table = "student_enrollments";
  pageLimit = 10;
  updated_at = true;

}

module.exports = StudentEnrollmentModel;