const _ = require('lodash');
const moment = require('moment');
const bcrypt = require('bcryptjs');
const apiutils = require('./../routes/apiutils');
const BaseModel = require('./BaseModel');
const Emailer = require('./EmailModel');
const RoleModel = require('./RoleModel');
const TModel = require('./TrainerModel');

class UserModel extends BaseModel {

  table = "users";
  pageLimit = 10;

  checkLogin(data) {
    let ret = { success: false, message: 'Login failed: Invalid User credentials entered!'};

    return this.db.run('SELECT * FROM users WHERE email=? LIMIT 1', [data.user])
      .then(res => {
        if (res.length === 1) {
          if(bcrypt.compareSync(data.pass,res[0]['password'])){
            ret['success'] = true;
            ret['message'] = "Login successful!";
            ret['token'] = apiutils.genToken({
              id: res[0].id,
              role_id: res[0].role_id,
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
    let roleName = null;
    data.password = bcrypt.hashSync(data.password, 8); //== encrypt the password
    // data.rbac = "[]";
    data.active = 1;

    return this.checkUnique('email',data.email)
    // .then(() => this.checkUnique('email',data.email))
    .then(() => (new RoleModel()).find(data.role))
    .then(rec => {
      roleName = rec.title;
      data['role_id']=rec.id;
      data = _.omit(data,['role']);
    })
    .then(() => super.add(data))
    .then(res => {
      if(res.success){
        
        const finalEmail = () => {
          return Emailer.sendEmail({
            to: data.email,
            subject: `WELCOME ${roleName}`,
            html: this.newUserEmail({...data, origpass: origpass, role: roleName})
          })
          .then(res1 => {
            return res;
          });
        }

        if(parseInt(data.role_id)===parseInt(process.env.TRAINER_ROLE)){
          return (new TModel.TrainerAbout()).add({..._.pick(data,['firstname','middlename','lastname']), user_id: res.insertId})
          .then(finalEmail)
        }else{
          return finalEmail();
        }
        
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

  newUserEmail(data){
    let html = `<p>Hi ${data.firstname} (${data.role}),</p>
    <p>Welcome to ${process.env.APP_NAME}.</p>
    <p>You can use the following credetials to <a href="${process.env.APP_URL}/login">login to your ${data.role} area</a></p>
    <p>Username: <b>${data.email}</b></p>
    <p>Password: <b>${data.origpass}</b></p>
    <p>Please do not share your credentials to avoid sensitive data breach.</p>
    Good Luck.<br />
    Administrator`;

    return html;
  }

  
  
}

module.exports = UserModel;