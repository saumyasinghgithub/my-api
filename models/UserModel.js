const _ = require('lodash');
const moment = require('moment');
const bcrypt = require('bcryptjs');
const apiutils = require('./../routes/apiutils');
const BaseModel = require('./BaseModel');
const Emailer = require('./EmailModel');

class UserModel extends BaseModel {

  table = "users";
  pageLimit = 10;

  checkLogin(data) {
    let ret = { success: false, message: 'Login failed: Invalid User credentials entered!'};

    return this.db.run('SELECT * FROM users WHERE username=? LIMIT 1', [data.user])
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

  buildWhereClause(attrs){
    attrs.sql += ` WHERE ${this.pk} <> 1`;
    return attrs;
  }

  add(data){
    const origpass = data.password;
    data.password = bcrypt.hashSync(data.password, 8); //== encrypt the password
    data.rbac = "[]";
    data.active = 1;
    return this.checkUnique('username',data.username)
    .then(() => this.checkUnique('email',data.email))
    .then(() => super.add(data))
    .then(res => {
      if(res.success){
        return Emailer.sendEmail({
          to: data.email,
          subject: "WELCOME ADMIN",
          html: this.newAdminEmail({...data, origpass: origpass})
        })
        .then(() => {
          return res;
        })
      }else{
        return res;
      }
    })
  }

  checkUnique(fld,val,id=0){
    return this.db.run(`SELECT id FROM ${this.table} WHERE ${fld}=? AND ${this.pk}<>?`,[val,id])
    .then(res => {
      if(_.get(res,'length',0) > 0){
        throw({message: `${fld} ${val} already exists.. Aborting..`});
      }
      return true;
    });
  }

  newAdminEmail(data){
    let html = `<p>Hi ${data.username},</p>
    <p>Welcome to ${process.env.APP_NAME}.</p>
    <p>You can use the following credetials to <a href="${process.env.APP_ADMIN_URL}/login">login to your admin area</a></p>
    <p>Username: <b>${data.username}</b></p>
    <p>Password: <b>${data.origpass}</b></p>
    <p>Please do not share your credentials to avoid sensitive data breach.</p>
    Good Luck.<br />
    Administrator`;

    return html;
  }

  
  
}

module.exports = UserModel;