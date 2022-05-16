const _ = require('lodash');
const moment = require('moment');
const apiutils = require('../routes/apiutils');
const BaseModel = require('./BaseModel');

class UserModel extends BaseModel {

  table = "users";
  pageLimit = 10;

  checkLogin(data) {
    return this.db.run('SELECT * FROM users WHERE username=? AND password=md5(?)  AND role=? LIMIT 1', [data.user, data.pass, data.role])
      .then(res => {
        let ret = { success: false };
        if (res.length === 1) {
          ret['success'] = true;
          ret['token'] = apiutils.genToken({
            id: res[0].id,
            email: res[0].email,
            validTill: moment().add(1, 'hours').unix()
          });
        } else {
          ret['error'] = 'Login failed: Invalid User credentials entered!';
        }
        return ret;
      }
      );
  }

  

}

module.exports = UserModel;