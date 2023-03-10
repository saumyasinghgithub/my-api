const _ = require("lodash");
const moment = require("moment");
const BaseModel = require("./BaseModel");
const CartModel = require("./CartModel");
const { isTrainer } = require("../routes/apiutils");
const StudentEnrollmentModel = require("./StudentEnrollmentModel");
const Emailer = require("./EmailModel");
const UserModel = require("./UserModel");
const MoodleAPI = require("./MoodleAPI");

class PaymentModel extends BaseModel {
  table = "payments";
  pageLimit = 10;
  updated_at = true;

  orderSuccess(orderData) {
    let ret = { success: true };

    return new Promise((resolve, reject) => {
      if (orderData.user_id) {
        var { validatePaymentVerification } = require("razorpay/dist/utils/razorpay-utils");

        try {
          ret.success = validatePaymentVerification(
            {
              order_id: orderData.razorpayOrderId,
              payment_id: orderData.razorpayPaymentId,
            },
            orderData.razorpaySignature,
            process.env.RAZORPAY_SECRET
          );

          if (ret.success) {
            this.add({
              user_id: orderData.user_id,
              payment_id: orderData.razorpayPaymentId,
              items: orderData.notes.cartItems,
              currency: orderData.currency,
              amount: orderData.amount / 100,
              dump: JSON.stringify(_.pick(orderData, ["name", "description", "razorpayOrderId"])),
              is_complete: true,
            })
              .then((res) => {
                ret.success = res.success;
                ret.message = res.success ? "Payment processed successfully!" : "Adding payment details failed!";
                ret.id = res.insertId;
              })
              .then(() => this.updateCartItems(JSON.parse(orderData.notes.cartItems)))
              .then(() => this.enrollStudents(orderData.user_id, JSON.parse(orderData.notes.cartItems)))
              .then(() => this.notifyPayment2User(orderData))
              .then(() => resolve(ret))
              .catch(reject);
          }
        } catch (err) {
          ret["success"] = false;
          ret["message"] = err.message;
          resolve(ret);
        }
      } else {
        ret["success"] = false;
        ret["message"] = "Please login to continue..";
        resolve(ret);
      }
    });
  }

  getOrdertData({ id, user_id }) {
    return this.find(id).then((res) => (res["user_id"] === user_id ? res : false));
  }

  updateCartItems(cartItems) {
    const cartObj = new CartModel();
    return new Promise((resolve, reject) => {
      let idx = -1;
      const updateCartItem = () => {
        if (++idx >= cartItems.length) {
          resolve();
        } else {
          let ci = cartItems[idx];
          cartObj.edit({ status: "paid" }, ci.id).finally(updateCartItem);
        }
      };

      updateCartItem();
    });
  }

  enrollStudents(user_id, cartItems) {
    const seObj = new StudentEnrollmentModel();
    return new Promise((resolve, reject) => {
      let idx = -1;
      const enrollStudent = () => {
        if (++idx >= cartItems.length) {
          resolve();
        } else {
          let ci = cartItems[idx];
          seObj
            .add({
              user_id: user_id,
              course_id: ci.course,
              resources: ci.resources.join(","),
            })
            .then(() =>
              this.enrollSICMoodle({
                user_id: user_id,
                course_id: ci.course,
              })
            )
            .finally(enrollStudent);
        }
      };

      enrollStudent();
    });
  }

  extractMoodleIds({ user_id, course_id }) {
    let mid = { userid: 0, courseid: 0 };
    return this.db
      .run(`SELECT moodle_id FROM users WHERE id=?`, user_id)
      .then((res) => (mid.userid = _.get(res, "0.moodle_id", 0)))
      .then(() => this.db.run(`SELECT moodle_id FROM courses WHERE id=?`, course_id))
      .then((res) => (mid.courseid = _.get(res, "0.moodle_id", 0)))
      .then(() => mid);
  }

  enrollSICMoodle({ user_id, course_id }) {
    return this.extractMoodleIds({ user_id, course_id }).then((mid) => {
      if (mid.userid > 0 && mid.courseid > 0) {
        return new MoodleAPI().setCourseUser({
          userid: mid.userid,
          courseid: mid.courseid,
          roleid: parseInt(process.env.MOODLE_STUDENT_ROLE),
        });
      }
    });
  }

  notifyPayment2User(orderData) {
    new UserModel().find(orderData.user_id).then((udata) => {
      return Emailer.sendEmail({
        to: udata.email,
        cc: "rajeshs@knowledgesynonyms.com, surojitb@knowledgesynonyms.com",
        subject: `${process.env.APP_NAME} Order Confirmation Email  `,
        html: this.paymentEmail({ ...orderData, ...udata }),
      });
    });
  }

  paymentEmail(data) {
    let dData = data.dump;
    let html = `<table width="600px" cellspacing="0" cellpadding="5" border="0" bgcolor="#ffffff" align="center" style="border:1px solid #d6dbdf;">
    <tr><td>
    <table width="100%" cellspacing="0" cellpadding="5" border="0" bgcolor="#ffffff" align="center">
    <tr>
    <td><img src="http://demo.knowledgesynonyms.com/adnew/pub/media/logo/stores/1/AD-logo.png" title="AD logo" alt="AD logo" width="200" ></td>
    <td></td>
    </tr>
    </table>
    <table width="600" cellspacing="0" cellpadding="0" border="0" bgcolor="#ffffff" align="center">
    <tr>
    <td colspan="2"><img src="http://demo.knowledgesynonyms.com/adnew/pub/media/Help_for_trainers.jpg" alt="" width="100%" height="200"></td>
    </tr>
    </table>
    <table width="600" cellspacing="0" cellpadding="0" border="0" bgcolor="#ffffff" align="center">
    <tr>
    <td colspan="2">
    <p style="padding:30px 10px">Autodidact makes the search for a trainer easier for students. So, by coming on this platform you will be able to maximize your reach to professional who need guidance and other skill enhancement programs. It also helps Companies find you. It makes it easier for them to look for professionals with expertise.</p></td>
    </tr>
    <tr><td colspan="2" align="center"><h1>Hello ${data.firstname}, Thank you for your order!</h1></td></tr>
    <tr><td colspan="2"><h2 style="color:#0f79aa;">Transaction Details:</h2></td></tr>
    <tr><td colspan="2">
    <p>Transaction ID: <b>${data.razorpayPaymentId}</b></p>
    <p>Order Amount: <b>${data.currency} ${data.amount / 100}</b></p>
    <p>Order ID: <b>${_.get(data, "razorpayOrderId")}</b></p>
    </td></tr>
    </table>
    <table width="600" cellspacing="" cellpadding="5" border="0" bgcolor="#ffffff" align="center" style="border: 1px solid black;border-collapse: collapse; margin:30px 10px;">
    <tr>
    <th align="center" style="border: 1px solid black;border-collapse: collapse;">Items Description</th>
    <th align="center" style="border: 1px solid black;border-collapse: collapse;">Price</th>
    </tr>
    <tr>
    <td align="center" style="border: 1px solid black;border-collapse: collapse;">
    <p>${_.get(data, "description")}<p>
    </td>
    <td align="center" style="border: 1px solid black;border-collapse: collapse;">${data.currency} ${data.amount / 100}</td>
    </tr>
    </table>
    
    <table width="600" cellspacing="0" cellpadding="0" border="0" style="background-color:#dc3016 !important; color:#fff;" align="center">
    <tr>
    <td><ul style="list-style: none;float: left;margin:0 10px;padding:0;">
    <li style="display: inline-block;padding: 15px 5px ;">Copyright © 2022 AD</li>
    <li style="display: inline-block;padding: 15px 5px;"><a href="http://demo.knowledgesynonyms.com/adnew/terms" style="color:#fff;">Terms</a></li>
    <li style="display: inline-block;padding:15px 5px;"><a href="http://demo.knowledgesynonyms.com/adnew/privacy-policy" style="color:#fff;">Privacy Policy</a></li>
    
    </ul></td>
    <td>
    <ul style="list-style: none;float: right;margin:0 10px;padding:0;">
    <li style="display: inline-block;padding: 15px 5px;"><img src="http://demo.knowledgesynonyms.com/adnew/pub/media/fb.png" alt=""></li>
    <li style="display: inline-block;padding: 15px 5px;"><img src="http://demo.knowledgesynonyms.com/adnew/pub/media/in.png" alt=""></li>
    <li style="display: inline-block;padding: 15px 5px;"><img src="http://demo.knowledgesynonyms.com/adnew/pub/media/twitter.png" alt=""></li>
    </ul>
    </td>
    </tr>
    </table>
    
    </td>
    </tr>
    </table>`;

    return html;
  }

  notifyEnrolledUser({ email, username, courseName }) {
    return Emailer.sendEmail({
      to: email,
      cc: "rajeshs@knowledgesynonyms.com, surojitb@knowledgesynonyms.com",
      subject: `${process.env.APP_NAME} Order Confirmation Email  `,
      html: this.enrolledByTeacherEmail({ username, courseName }),
    });
  }

  enrolledByTeacherEmail({ username, courseName }) {
    let html = `<table width="600px" cellspacing="0" cellpadding="5" border="0" bgcolor="#ffffff" align="center" style="border:1px solid #d6dbdf;">
    <tr><td>
    <table width="100%" cellspacing="0" cellpadding="5" border="0" bgcolor="#ffffff" align="center">
    <tr>
    <td><img src="http://demo.knowledgesynonyms.com/adnew/pub/media/logo/stores/1/AD-logo.png" title="AD logo" alt="AD logo" width="200" ></td>
    <td></td>
    </tr>
    </table>
    <table width="600" cellspacing="0" cellpadding="0" border="0" bgcolor="#ffffff" align="center">
    <tr>
    <td colspan="2"><img src="http://demo.knowledgesynonyms.com/adnew/pub/media/Help_for_trainers.jpg" alt="" width="100%" height="200"></td>
    </tr>
    </table>
    <table width="600" cellspacing="0" cellpadding="0" border="0" bgcolor="#ffffff" align="center">
    <tr>
    <td colspan="2">
    <p style="padding:30px 10px">Autodidact makes the search for a trainer easier for students. So, by coming on this platform you will be able to maximize your reach to professional who need guidance and other skill enhancement programs. It also helps Companies find you. It makes it easier for them to look for professionals with expertise.</p></td>
    </tr>
    <tr><td colspan="2" align="center"><h1>Hello ${username}, Thank you for your order!</h1></td></tr>
    <tr><td colspan="2"><h2 style="color:#0f79aa;">Transaction Details:</h2></td></tr>
    <tr><td colspan="2">
    <p>Enrolled Course: <b>${courseName}</b></p>
    </td></tr>
    </table>
    <table width="600" cellspacing="" cellpadding="5" border="0" bgcolor="#ffffff" align="center" style="border: 1px solid black;border-collapse: collapse; margin:30px 10px;">
    <tr>
    <th align="center" style="border: 1px solid black;border-collapse: collapse;">Items Description</th>
    <th align="center" style="border: 1px solid black;border-collapse: collapse;">Price</th>
    </tr>
    </table>
    
    <table width="600" cellspacing="0" cellpadding="0" border="0" style="background-color:#dc3016 !important; color:#fff;" align="center">
    <tr>
    <td><ul style="list-style: none;float: left;margin:0 10px;padding:0;">
    <li style="display: inline-block;padding: 15px 5px ;">Copyright © 2022 AD</li>
    <li style="display: inline-block;padding: 15px 5px;"><a href="http://demo.knowledgesynonyms.com/adnew/terms" style="color:#fff;">Terms</a></li>
    <li style="display: inline-block;padding:15px 5px;"><a href="http://demo.knowledgesynonyms.com/adnew/privacy-policy" style="color:#fff;">Privacy Policy</a></li>
    
    </ul></td>
    <td>
    <ul style="list-style: none;float: right;margin:0 10px;padding:0;">
    <li style="display: inline-block;padding: 15px 5px;"><img src="http://demo.knowledgesynonyms.com/adnew/pub/media/fb.png" alt=""></li>
    <li style="display: inline-block;padding: 15px 5px;"><img src="http://demo.knowledgesynonyms.com/adnew/pub/media/in.png" alt=""></li>
    <li style="display: inline-block;padding: 15px 5px;"><img src="http://demo.knowledgesynonyms.com/adnew/pub/media/twitter.png" alt=""></li>
    </ul>
    </td>
    </tr>
    </table>
    
    </td>
    </tr>
    </table>`;

    return html;
  }

  sales(userData) {
    let refine = "";
    let ary = [];
    let ret = { success: false };
    return this.db
      .run("SELECT COUNT(DISTINCT(" + this.pk + ")) as total FROM " + this.table + refine, ary)
      .then((res) => {
        if (res) {
          ret["pageInfo"] = {
            hasMore: res[0].total - parseInt(_.get(userData, "start", 0)) > parseInt(_.get(userData, "limit", this.pageLimit)),
            total: res[0].total,
          };
        } else {
          throw { message: "SQL failed!" };
        }
      })
      .then(() => {
        refine += " WHERE";
        if (_.get(userData.where.startDate, "where", false) && _.get(userData.where.endDate, "where", false)) {
          refine += " (payments.created_at BETWEEN ? AND ?) AND ";
          ary.push(_.get(userData.where.startDate, "where", this.sortBy));
          ary.push(_.get(userData.where.endDate, "where", this.sortBy));
        }
        if (isTrainer(userData.userData)) {
          refine += ` JSON_EXTRACT(payments.items,'$[0].course') IN (SELECT id FROM courses WHERE user_id=?) AND `;
          ary.push(_.get(userData.user_id, "where", userData.user_id));
        }
        refine += " payments.is_complete = 1 ORDER BY ? ? LIMIT ?,?";
        ary.push(_.get(userData, "sortBy", this.sortBy));
        ary.push(_.get(userData, "sortDir", this.sortDir));
        ary.push(parseInt(_.get(userData, "start", 0)));
        ary.push(parseInt(_.get(userData, "limit", this.pageLimit)));
        return this.db.run(
          `SELECT payments.id, payments.items,JSON_EXTRACT(payments.items,'$[0].course') AS courseID,users.firstname, users.middlename, users.lastname, payments.amount, payments.dump , JSON_EXTRACT(payments.dump,'$.razorpayOrderId') AS orderId,DATE_FORMAT(payments.created_at,"%Y-%m-%d") AS created_at, UNIX_TIMESTAMP(payments.created_at) AS timestampvalue, users.email, users.country, courses.name FROM payments LEFT JOIN users ON payments.user_id = users.id LEFT JOIN courses ON JSON_EXTRACT(payments.items,'$[0].course') = courses.id` +
            refine,
          ary
        );
      })
      .then((res) => {
        if (res) {
          ret["success"] = true;
          ret["data"] = res;
        } else {
          ret["error"] = "No data found";
        }
        return ret;
      });
  }
  trainersales(userData) {
    let refine = "";
    let ary = [];
    let ret = { success: false };
    return this.db
      .run("SELECT COUNT(DISTINCT(" + this.pk + ")) as total FROM " + this.table + refine, ary)
      .then((res) => {
        if (res) {
          ret["pageInfo"] = {
            hasMore: res[0].total - parseInt(_.get(userData, "start", 0)) > parseInt(_.get(userData, "limit", this.pageLimit)),
            total: res[0].total,
          };
        } else {
          throw { message: "SQL failed!" };
        }
      })
      .then(() => {
        console.log(userData.where.startDate);
        console.log(userData.where.endDate);
        if (userData.where.startDate !== "undefined" && userData.where.endDate !== "undefined") {
          refine += `created_at BETWEEN ? AND ? ) as earning, (select CONCAT_WS(' ', firstname,lastname) FROM trainer_about WHERE user_id=c.user_id) as trainer FROM courses c WHERE c.user_id IN (select id FROM users WHERE role_id=4) AND name LIKE '%ce%' LIMIT ?,?`;
          ary.push(_.get(userData.where.startDate, "where", this.sortBy));
          ary.push(_.get(userData.where.endDate, "where", this.sortBy));
        } else {
          refine += `created_at < NOW()) as earning, (select CONCAT_WS(' ', firstname,lastname) FROM trainer_about WHERE user_id=c.user_id) as trainer FROM courses c WHERE c.user_id IN (select id FROM users WHERE role_id=4) AND name LIKE '%ce%' LIMIT ?,?`;
        }

        ary.push(parseInt(_.get(userData, "start", 0)));
        ary.push(parseInt(_.get(userData, "limit", this.pageLimit)));
        console.log(`SELECT c.id,c.name,(SELECT SUM(amount) FROM payments WHERE JSON_SEARCH(items,'all',c.id) IS NOT NULL AND ` + refine, ary);
        return this.db.run(`SELECT c.id,c.name,(SELECT SUM(amount) FROM payments WHERE JSON_SEARCH(items,'all',c.id) IS NOT NULL AND ` + refine, ary);
      })
      .then((res) => {
        if (res) {
          ret["success"] = true;
          ret["data"] = res;
        } else {
          ret["error"] = "No data found";
        }
        return ret;
      });
  }
}

module.exports = PaymentModel;
