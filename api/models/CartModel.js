const _ = require("lodash");
const moment = require("moment");
const BaseModel = require("./BaseModel");
const CouponsModel = require("./CouponsModel");
const Razorpay = require("razorpay");

class CartModel extends BaseModel {
  table = "cart";
  pageLimit = 10;
  updated_at = true;

  add(data) {
    return this.deleteWhere({ user_id: data.user_id, course_id: data.course_id, status: "queue" }).then(() => super.add(data));
  }

  getCartData({ user_id }) {
    let sql = `SELECT c.slug, c.name, c.course_image, ca.* FROM cart ca
    INNER JOIN courses c ON ca.course_id = c.id  
    WHERE ca.user_id = ? AND ca.status=? 
    ORDER BY ca.id DESC`;
    return this.db.run(sql, [user_id, "queue"]);
  }

  delete(pkval, user_id) {
    return this.find(pkval).then((rec) => {
      if (rec.user_id == user_id && rec.status == "queue") {
        return super.delete(pkval);
      } else {
        throw "Invalid data access!";
      }
    });
  }

  clearCart(user_id) {
    return this.deleteWhere({ user_id: user_id, status: "queue" });
  }

  applyCoupon(coupon_id, user_id) {
    return new Promise((resolve, reject) => {
      if (coupon_id) {
        new CouponsModel()
          .find(coupon_id)
          .then((coupon) => {
            if (coupon.id) {
              this.verifyCoupon(coupon, user_id).then((verified) => resolve(verified ? coupon : false));
            }
          })
          .catch((err) => resolve(false));
      } else {
        resolve(false);
      }
    });
  }

  verifyCoupon(coupon, user_id) {
    return new Promise((resolve, reject) => {
      if (!_.isEmpty(coupon.expiry_date) && coupon.expiry_date !== "0000-00-00" && moment(coupon.expiry_date).isBefore(moment())) {
        //== coupon has expired
        resolve(false);
      } else if (coupon.usage_limit) {
        this.db.run(`SELECT count(1) as total FROM payments WHERE is_complete=1 AND user_id=${user_id} AND coupon_id=${coupon.id}`).then((res) => {
          let alreadyUsed = parseInt(_.get(res, "0.total", 0));
          resolve(alreadyUsed < parseInt(coupon.usage_limit));
        });
      } else {
        resolve(true);
      }
    });
  }

  generateOrder({ action, coupon_id, user_id }) {
    let rPay = new Razorpay({
      key_id: process.env.RAZORPAY_KEY,
      key_secret: process.env.RAZORPAY_SECRET,
    });

    let coupon = false;

    return this.applyCoupon(coupon_id, user_id)
      .then((couponData) => {
        coupon = couponData;
        console.log(coupon);
        process.exit();
      })
      .then(() => this.getCartData({ user_id: user_id }))
      .then((data) => {
        let order = {
          amount: parseInt(_.sum(data.map((d) => d.price))) * 100, // cents to USD
          currency: process.env.RAZORPAY_CURRENCY,
          receipt: `AD#${user_id}-${moment().format("YYYYMMDDHHmmss")}`,
          notes: {},
        };

        let cartItems = [];

        data.forEach((d) => {
          let cres = JSON.parse(d.course_resources);
          cartItems.push({ id: d.id, course: parseInt(d.course_id), resources: cres.map((cr) => cr.id) });
          order.notes[`cart_${d.id}`] = d.name + "||" + cres.map((cr) => cr.type).join("||");
        });

        order.notes["cartItems"] = JSON.stringify(cartItems);

        return rPay.orders.create(order);
      })
      .then((orderData) => {
        return {
          success: true,
          data: {
            key: process.env.RAZORPAY_KEY,
            currency: orderData.currency,
            amount: orderData.amount,
            name: `Bundle Course - ${Object.values(orderData.notes).length}`,
            description: Object.values(_.omit(orderData.notes, ["cartItems"])).join(" AND "),
            notes: orderData.notes,
            order_id: orderData.id,
          },
        };
      });
  }

  sales(params) {
    let refine = "";
    let ary = [];

    if (_.get(params, "where", false)) {
      refine += " AND cart.user_id=?";
      console.log(params.where.user_id);
      ary.push(parseInt(_.get(params, "user_id", params.where.user_id)));
    }

    if (_.get(params, "startDate", false)) {
      refine += " AND payments.created_at BETWEEN ? AND ?";
      console.log(params.startDate);
      ary.push(_.get(params, "startDate", params.startDate));
      ary.push(_.get(params, "endDate", params.endDate));
    }

    let ret = { success: false };
    let sqlQuery = `SELECT cart.id, cart.user_id, cart.price, courses.name as course_name, CONCAT(users.firstname," ",users.middlename," ",users.lastname) AS fullname, users.firstname, users.middlename, users.lastname, cart.course_resources FROM cart
    RIGHT JOIN courses ON cart.course_id = courses.id
    RIGHT JOIN users ON cart.user_id = users.id
    RIGHT JOIN payments ON cart.user_id = payments.user_id
    where cart.status = 'paid'`;

    refine += " LIMIT ?,?";
    ary.push(parseInt(_.get(params, "start", 0)));
    ary.push(parseInt(_.get(params, "limit", this.pageLimit)));

    return this.db
      .run(
        `SELECT COUNT(cart.id) as total, cart.id, cart.user_id, cart.price, courses.name as course_name, CONCAT(users.firstname," ",users.middlename," ",users.lastname) AS fullname, users.firstname, users.middlename, users.lastname, cart.course_resources FROM cart
    RIGHT JOIN courses ON cart.course_id = courses.id
    RIGHT JOIN users ON cart.user_id = users.id
    where cart.status = 'paid'`
      )
      .then((ress) => {
        if (ress) {
          ret["pageInfo"] = {
            hasMore: ress[0].total - parseInt(_.get(params, "start", 0)) > parseInt(_.get(params, "limit", this.pageLimit)),
            total: ress[0].total,
          };
          ret["success"] = true;
          ret["message"] = "list of data";
          ret["data"] = ress;
        } else {
          ret["error"] = "No data found";
        }
        return ret;
      })
      .then(() => {
        return this.db.run(sqlQuery + refine, ary);
      })
      .then((res) => {
        if (res) {
          ret["success"] = true;
          ret["data"] = res;
        } else {
          ret["error"] = "No data found";
        }
        console.log(sqlQuery + refine, ary);
        return ret;
      });
  }
}

module.exports = CartModel;
