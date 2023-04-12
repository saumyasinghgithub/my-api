const _ = require("lodash");
const moment = require("moment");
const bcrypt = require("bcryptjs");
const apiutils = require("./../routes/apiutils");
const BaseModel = require("./BaseModel");
const Emailer = require("./EmailModel");
const RoleModel = require("./RoleModel");
const TModel = require("./TrainerModel");
const MoodleAPI = require("./MoodleAPI");
const fs = require("fs");
const path = require("path");

class UserModel extends BaseModel {
  table = "users";
  pageLimit = 10;

  checkLogin(data) {
    let ret = {
      success: false,
      message: "Login failed: Invalid User credentials entered!",
    };
    let sqlQuery = `SELECT IF(u.role_id = ?, ta.slug, sa.slug) slug, IF(u.role_id = ?, ta.base_image, sa.base_image) base_image, u.*  FROM users u
    LEFT JOIN trainer_about ta ON u.id = ta.user_id  
    LEFT JOIN student_about sa ON u.id = sa.user_id
    WHERE u.email = ? LIMIT 1`;

    return new Promise((resolve, reject) => {
      this.db
        .run(sqlQuery, [
          process.env.TRAINER_ROLE,
          process.env.TRAINER_ROLE,
          data.user,
        ])
        .then((res) => {
          if (res.length === 1) {
            if (bcrypt.compareSync(data.pass, res[0]["password"])) {
              const finallyResolve = () => {
                ret["success"] = true;
                ret["message"] = "Login successful!";
                ret["token"] = apiutils.genToken({
                  id: res[0].id,
                  role_id: res[0].role_id,
                  validTill: moment().add(1, "hours").unix(),
                });
                ret = { ...ret, userData: _.omit(res[0], ["password"]) };
                let fpath;
                if(ret.userData.role_id === process.env.STUDENT_ROLE){
                  fpath = path.resolve('public','uploads', 'student','base',ret.userData.base_image);
                } else {
                  fpath = path.resolve('public','uploads','base',ret.userData.base_image);
                }
                if(!fs.existsSync(fpath)){
                  ret.userData.base_image = 'default.png';
                }
                //path.join(ret.userData.base_image);
                resolve(ret);
              };

              if (parseInt(res[0]["moodle_id"]) > 0) {
                finallyResolve();
              } else {
                this.createMoodleUser({
                  username: data.user.toLowerCase(),
                  password: data.pass,
                  firstname: res[0].firstname,
                  lastname: res[0].lastname,
                  email: data.user.toLowerCase(),
                  id: res[0].id,
                  role_id: res[0].role_id,
                }).finally(finallyResolve);
              }
            } else {
              resolve(ret);
            }
          } else {
            resolve(ret);
          }
        });
    });
  }

  forgotPassword({ email }) {
    let ret = {
      success: true,
      message: `We found ${email} registered with us and sent you an email to reset your password. Please check your email ${email}.`,
    };

    return new Promise((resolve, reject) => {
      this.findBy({ fname: "email", fvalue: email }).then((res) => {
        if (_.get(res, "0.email", "") === email) {
          const token = apiutils.genToken({
            id: res[0].id,
            validTill: moment().add(48, "hours").unix(),
          });

          this.sendForgotPasswordEmail({ ...res[0], token: token })
            .then(() => resolve(ret))
            .catch((err) => resolve({ success: false, message: err.message }));
        } else {
          resolve({
            success: false,
            message: `${email} is not registered with us!`,
          });
        }
      });
    });
  }

  resetPassword({ password, vpass }) {
    return new Promise((resolve, reject) => {
      if (vpass.success) {
        this.edit(
          { password: bcrypt.hashSync(password, 8) },
          vpass.data.id
        ).then((ret) => {
          if (ret.success) {
            this.updateMoodleUser(vpass.data.id, { password: password }).then(
              (updated) =>
                resolve({
                  success: true,
                  message:
                    "Your password has been updated! Please use new password to login!",
                })
            );
          } else {
            resolve({
              success: false,
              message: "Not able to reset your password, please try again!",
            });
          }
        });
      } else {
        resolve({ success: false, message: vpass.message });
      }
    });
  }

  changePassword({ user_id, current_password, password }) {
    return new Promise((resolve, reject) => {
      if (user_id) {
        this.find(user_id).then((user) => {
          if (bcrypt.compareSync(current_password, user["password"])) {
            return this.edit(
              { password: bcrypt.hashSync(password, 8) },
              user_id
            ).then((ret) => {
              if (ret.success) {
                this.updateMoodleUser(user_id, { password: password }).then(
                  (updated) =>
                    resolve({
                      success: true,
                      message:
                        "Your password has been updated! Please use new password to login!",
                    })
                );
              } else {
                resolve({
                  success: false,
                  message: "Not able to reset your password, please try again!",
                });
              }
            });
          } else {
            resolve({
              success: false,
              message: "Incorrect current password entered!",
            });
          }
        });
      } else {
        resolve({ success: false, message: "Invalid access!" });
      }
    });
  }

  buildWhereClause(attrs) {
    if (_.get(attrs, "where", false)) {
      return super.buildWhereClause(attrs);
    } else {
      attrs.sql += ` WHERE ${this.pk} <> 1`;
      return attrs;
    }
  }

  createMoodleUser(data) {
    const mobj = new MoodleAPI();
    return mobj
      .createUser({
        username: data.username,
        password: data.password,
        firstname: data.firstname,
        lastname: data.lastname,
        email: data.email,
        auth: "manual",
      })
      .then((res) => {
        console.log(res);
        let mid = parseInt(_.get(res, "[0].id", 0));
        if (mid > 0) {
          return mobj
            .assignUserRole({
              userid: mid,
              roleid: parseInt(
                parseInt(data.role_id) === parseInt(process.env.TRAINER_ROLE)
                  ? process.env.MOODLE_TEACHER_ROLE
                  : process.env.MOODLE_STUDENT_ROLE
              ),
            })
            .then(() => super.edit({ moodle_id: mid }, data.id))
            .then(() => {
              return res;
            });
        }
        return res;
      });
  }

  updateMoodleUser(user_id, data) {
    const mobj = new MoodleAPI();
    return this.find(user_id).then((user) => {
      if (!_.isNull(user["moodle_id"]) && user["moodle_id"] > 0) {
        return mobj
          .updateUser({ ...data, id: user["moodle_id"] })
          .then(() => true);
      } else {
        return false;
      }
    });
  }

  add(data) {
    const origpass = data.password;
    let roleName = null;
    data.password = bcrypt.hashSync(data.password, 8); //== encrypt the password
    // data.rbac = "[]";
    data.active = 1;

    return (
      this.checkUnique("email", data.email)
        .then(() => this.checkUnique('mobile',data.mobile))
        .then(() => new RoleModel().find(data.role))
        .then((rec) => {
          roleName = rec.title;
          data["role_id"] = rec.id;
          data = _.omit(data, ["role"]);
        })
        .then(() => super.add(data))
        .then((res) => {
          if (res.success) {
            const finalEmail = () => {
              return Emailer.sendEmail({
                to: data.email,
                subject: `WELCOME ${roleName}`,
                html: this.newUserEmail({
                  ...data,
                  origpass: origpass,
                  role: roleName,
                }),
              }).then((res1) => {
                return res;
              });
            };

            return this.createMoodleUser({
              ...data,
              username: data.email,
              password: origpass,
              id: res.insertId,
            }).then(() => {
              if (
                parseInt(data.role_id) === parseInt(process.env.TRAINER_ROLE)
              ) {
                return new TModel.TrainerAbout()
                  .add({
                    ..._.pick(data, ["firstname", "middlename", "lastname"]),
                    user_id: res.insertId,
                  })
                  .then(finalEmail);
              } else {
                return finalEmail();
              }
            });
          } else {
            return res;
          }
        })
    );
  }

  checkUnique(fld, val, id = 0) {
    return this.db
      .run(`SELECT id FROM ${this.table} WHERE ${fld}=? AND ${this.pk}<>?`, [
        val,
        id,
      ])
      .then((res) => {
        if (_.get(res, "length", 0) > 0) {
          throw { message: `This is a duplicate entry for ${fld} ${val} Aborting..` };
        }
        return true;
      });
  }

  newUserEmail(data) {
    const trainerUrl = 'https://dr-susan-davis.kstverse.com/login';
    let html = `<p>Hi ${data.firstname} (${data.role}),</p>
    <p>Welcome to ${process.env.APP_NAME}.</p>
    <p>You can use the following credentials to <a href="${trainerUrl}">login to your student area.</a></p>
    <p>Username: <b>${data.email}</b></p>
    <p>Password: <b>${data.origpass}</b></p>
    <p>Please do not share your credentials to avoid sensitive data breach.</p>
    Good Luck.<br />
    Administrator`;

    return html;
  }

  sendForgotPasswordEmail(userData) {
    return Emailer.sendEmail({
      to: userData.email,
      subject: `${process.env.APP_NAME}::RESET YOUR PASSWORD`,
      html: this.forgotPasswordEmail({
        name: userData.firstname + " " + userData.lastname,
        token: userData.token,
      }),
    }).then(console.log);
  }

  forgotPasswordEmail({ name, token }) {
    let html = `<p>Hi ${name}),</p>
    <p>${process.env.APP_NAME}.</p>
    <p>We have processed your request to reset your password.</p>
    <p><a href="${process.env.APP_URL}/resetpass/${token}">Click here</a> to reset your password</p>
    <p>Click Here ${process.env.APP_URL}/resetpass/${token}</p>
    <p>Please do not share your credentials to avoid sensitive data breach.</p>
    Good Luck.<br />
    Administrator`;
    return html;
  }

  markfav({ user_id, trainer_id, fav }) {
    return new Promise((resolve, reject) => {
      this.db
        .run(`DELETE FROM favorites WHERE user_id=? AND trainer_id=?`, [
          user_id,
          trainer_id,
        ])
        .then(() => {
          if (parseInt(fav) === 1) {
            return this.db.run(
              `INSERT INTO favorites (user_id,trainer_id) VALUES (?,?)`,
              [user_id, trainer_id]
            );
          }
        })
        .then(() => resolve({ success: true }))
        .catch(reject);
    });
  }
}

module.exports = UserModel;
