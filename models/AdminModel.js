const _ = require('lodash');
const moment = require('moment');
const bcrypt = require('bcryptjs');
const DBObject = require('./DB');
const apiutils = require('./../routes/apiutils');

class AdminModel {

  db = null;

  constructor() {
    this.db = DBObject;
  }

  checkLogin(data) {
    let ret = { success: false, message: 'Login failed: Invalid User credentials entered!'};

    return this.db.run('SELECT * FROM admins WHERE username=? LIMIT 1', [data.user])
      .then(res => {
        if (res.length === 1) {
          if(bcrypt.compareSync(data.pass,res[0]['password'])){
            ret['success'] = true;
            ret['message'] = "Login successful!";
            ret['token'] = apiutils.genToken({
              id: res[0].id,
              validTill: moment().add(1, 'hours').unix()
            });
            ret = {...ret, userData: _.omit(res[0],['password'])};
          }
        }

        return ret;
      });
  }

  listUsers(req) {
    //Fetch users from DB
    return this.db.run('SELECT * FROM users LIMIT 5', [])
      .then(res => {
        let ret = { success: false };
        // console.log(res);
        if (res) {
          ret['success'] = true;
          ret['data'] = res[0];
        } else {
          ret['error'] = 'No data found';
        }
        return ret;
      }
      );
  }

  addUser(data) {
    //Add user to DB

    return this.db.run('INSERT INTO `users` (`username`, `email`, `password`, `role`, `location`, `company`, `department`, `date_of_join`, `status`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [data.username,
      data.email,
      data.password,
      data.role,
      data.location,
      data.company,
      data.department,
      data.date_of_join,
      data.status
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

  editUser(data) {
    //Update user to DB
    let sql = this.db.getUpdateQuery('users', data, 'id')
    return this.db.run(sql,
      Object.values(data)
    )
      .then(res => {
        console.log(res);
        let ret = { success: false };
        if (res) {
          ret['success'] = true;
          ret['message'] = 'User Updated';
        } else {
          ret['error'] = 'Failed to Update user.';
        }
        return ret;
      });
  } 

  deleteUser(data) {
    //Delete user from DB
    let sql = `DELETE t1.*, t2.*, t3.*, t4.*, t5 
            FROM users t1 
            LEFT JOIN scenario_attempt_tbl t2 ON t1.id = t2.userid 
            LEFT JOIN score_tbl t3 ON t2.uid = t3.uid 
            LEFT JOIN open_res_tbl t4 ON t2.uid = t4.uid 
            LEFT JOIN multi_score_tbl t5 ON t2.uid = t5.uid 
            WHERE t1.id IN ( ? )`;
    return this.db.run('DELETE FROM users WHERE id = ?', [data.id])
      .then(res => {
        console.log(res);
        let ret = { success: false };
        if (res.affectedRows != 0) {
          ret['success'] = true;
          ret['message'] = 'User Deleted.';
        } else {
          ret['error'] = 'User does not exists to Delete.';
        }
        return ret;
      });
  }
  
}

module.exports = AdminModel;