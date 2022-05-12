const _ = require('lodash');
const moment = require('moment');
const apiutils = require('../routes/apiutils');
const BaseModel = require('../models/BaseModel');

class RoleModel extends BaseModel {

  table = "roles";
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

  addRole(data) {
    //Add role to DB

    return this.db.run('INSERT INTO `roles` (`title`, `slug`, `description`, `active`, `created_at`, `updated_at`, `content`) VALUES (?, ?, ?, ?, ?, ?, ?)',
      [data.title,
      data.slug,
      data.description,
      data.active,
      data.created_at,
      data.updated_at,
      data.content
      ])
      .then(res => {
        console.log(res);
        let ret = { success: false };
        if (res) {
          ret['success'] = true;
          ret['message'] = 'User added, ID =' + res.insertId;
        } else {
          ret['error'] = 'Failed to add user.';
        }
        return ret;
      });
  }

}

module.exports = RoleModel;