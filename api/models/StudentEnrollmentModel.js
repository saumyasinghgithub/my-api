const _ = require('lodash');
const BaseModel = require('./BaseModel');

class StudentEnrollmentModel extends BaseModel {

  table = "student_enrollments";
  pageLimit = 10;
  updated_at = true;

  getEnrolledDataByID(user_id) {
    let whereParams = { where: { user_id: user_id }, limit: 99999999 };
    let eData = {};
    return this.list(whereParams)
      .then(({ data }) => {
        eData.enrolled = data;

        return ({ ...eData, sucess: true });
      })
      .catch(e => ({ sucess: false, message: e.message }))
  }

}

module.exports = StudentEnrollmentModel;