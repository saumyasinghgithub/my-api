const axios = require("axios");
const _ = require("lodash");
const moment = require("moment");
const cfg = require("dotenv");
const path = require("path");
cfg.config({ path: path.join(__dirname, "..", ".env") });

//=== Base class
class MoodleAPIBase {
  token = null;
  api = null;
  domain = null;
  username = null;
  password = null;

  constructor(domain = null) {
    this.domain = process.env.LMS_DOMAIN; //domain;
    this.username = process.env.LMS_USER;
    this.password = process.env.LMS_PWD;
    this.api = `${this.domain}/webservice/rest/server.php`;
  }

  setToken(token) {
    this.token = token;
  }

  getToken() {
    return this.token;
  }

  login() {
    return new Promise((resolve, reject) => {
      if (this.getToken()) {
        resolve();
      } else {
        let url = `${this.domain}/login/token.php?service=moodle_api`;
        console.log(`username=${this.username}&password=${this.password}`);
        return axios.post(url, `username=${this.username}&password=${this.password}`).then((res) => {
          if (_.get(res, "data.token", false)) {
            this.setToken(res.data.token);
            resolve();
          } else {
            reject("Invalid Login");
          }
        });
      }
    });
  }

  hit(func, params) {
    /// REST CALL
    return this.login()
      .then(() => {
        let url = `${this.api}?moodlewsrestformat=json&wstoken=${this.getToken()}&wsfunction=${func}`;
        return axios.post(url, params).then((res) => res.data);
      })
      .catch(console.log);
  }
}

class MoodleAPI extends MoodleAPIBase {
  createUser(user) {
    let params = _.map(user, (v, k) => `users[0][${k}]=${encodeURIComponent(v)}`).join("&");
    return this.hit("core_user_create_users", params);
    //== returns moodle_id which needs to be stored in user's table moodle_id column
  }

  updateUser(user) {
    let params = _.map(user, (v, k) => `users[0][${k}]=${encodeURIComponent(v)}`).join("&");
    return this.hit("core_user_update_users", params);
    //== returns moodle_id which needs to be stored in user's table moodle_id column
  }

  assignUserRole(roleuser) {
    roleuser["contextid"] = process.env.MOODLE_CONTEXT_ID;
    let params = _.map(roleuser, (v, k) => `assignments[0][${k}]=${encodeURIComponent(v)}`).join("&");
    return this.hit("core_role_assign_roles", params);
  }

  createCourse(course) {
    course["categoryid"] = process.env.MOODLE_CATEGORY_ID;
    course["visible"] = 1;
    course["lang"] = "en";

    let params = _.map(course, (v, k) => `courses[0][${k}]=${encodeURIComponent(v)}`).join("&");
    return this.hit("core_course_create_courses", params);
    ///== another call needed for assignUserRole based on trainer's moodle_id
  }

  updateCourse(course) {
    course["categoryid"] = process.env.MOODLE_CATEGORY_ID;

    let params = _.map(course, (v, k) => `courses[0][${k}]=${encodeURIComponent(v)}`).join("&");
    return this.hit("core_course_update_courses", params);
  }

  setCourseUser(enrole) {
    //enrole['roleid']=process.env.MOODLE_STUDENT_ROLE;

    let params = _.map(enrole, (v, k) => `enrolments[0][${k}]=${encodeURIComponent(v)}`).join("&");
    return this.hit("enrol_manual_enrol_users", params);
  }

  setCourseUsers(userids, courseid) {
    let roleid = process.env.MOODLE_STUDENT_ROLE;
    let params = _.map(
      userids,
      (v, k) => `enrolments[${k}][courseid]=${courseid}&enrolments[${k}][roleid]=${roleid}&enrolments[${k}][userid]=${encodeURIComponent(v)}`
    ).join("&");
    return this.hit("enrol_manual_enrol_users", params);
  }

  createCourseGroup({ course_moodle_id, gname, gdesc }) {
    const group = {
      courseid: course_moodle_id,
      name: gname,
      description: gdesc,
    };

    let params = _.map(group, (v, k) => `groups[0][${k}]=${encodeURIComponent(v)}`).join("&");
    return this.hit("core_group_create_groups", params);
  }

  updateCourseGroup(gname, gdesc, group_moodle_ids = []) {
    let params = _.map(
      group_moodle_ids,
      (group_moodle_id, k) =>
        `groups[${k}][id]=${parseInt(group_moodle_id)}` +
        `&groups[${k}][name]=${encodeURIComponent(gname)}` +
        `&groups[${k}][description]=${encodeURIComponent(gdesc)}`
    ).join("&");
    return this.hit("core_group_update_groups", params);
  }

  addMembersToGroup(moodle_group_id = 0, members = []) {
    let params = _.map(
      members,
      (user_moodle_id, k) => `members[${k}][userid]=${parseInt(user_moodle_id)}&members[${k}][groupid]=${parseInt(moodle_group_id)}`
    ).join("&");
    return this.hit("core_group_add_group_members", params);
  }
}

module.exports = MoodleAPI;
