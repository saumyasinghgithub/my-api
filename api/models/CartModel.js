const _ = require("lodash");
const moment = require("moment");
const BaseModel = require("./BaseModel");
const CouponsModel = require("./CouponsModel");
const Razorpay = require("razorpay");
const paypal = require("paypal-rest-sdk");

class CartModel extends BaseModel {
  table = "cart";
  pageLimit = 10;
  updated_at = true;

  add(data) {
    return this.deleteWhere({ user_id: data.user_id, course_id: data.course_id, status: "queue" }).then(() => super.add(data));
  }

  getCartData({ user_id }) {
    let sql = `SELECT c.slug, c.user_id as trainer_id, c.name, c.sku, c.course_image, ca.* FROM cart ca
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

  getCouponDiscount(coupon, cartData) {
    let disAmount = 0;
    let cartTotalPrice = parseInt(_.sum(cartData.map((d) => d.price)));

    const cartHasMultiTrainerCourse = () => {
      return _.uniq(_.map(cartData, (d) => d.trainer_id)).length > 1;
    };

    const courseDiscountAmount = (cid, tid, price) => {
      let disAmount = 0;

      if (
        coupon &&
        ((!_.isEmpty(coupon.course_ids) && coupon.course_ids.split(",").includes(cid.toString())) ||
          (_.isEmpty(coupon.course_ids) && cartHasMultiTrainerCourse() && coupon.trainer_id === tid))
      ) {
        disAmount = coupon.coupon_type === 1 ? (price * coupon.discount_value) / 100 : price > coupon.discount_value ? coupon.discount_value : price;
      }

      return disAmount;
    };

    if (coupon) {
      if (_.isEmpty(coupon.course_ids) && !cartHasMultiTrainerCourse()) {
        disAmount =
          coupon.coupon_type === 1
            ? (cartTotalPrice * coupon.discount_value) / 100
            : cartTotalPrice > coupon.discount_value
            ? coupon.discount_value
            : cartTotalPrice;
      } else {
        disAmount = _.reduce(
          cartData.map((cData) => courseDiscountAmount(cData.course_id, cData.trainer_id, cData.price)),
          (sum, n) => sum + n,
          0
        );
      }
    }
    return parseFloat(disAmount);
  }

  generateOrder({ action, pgid, coupon_id, user_id }) {
    let coupon = false;
    let cartData = [];

    return this.applyCoupon(coupon_id, user_id)
      .then((couponData) => {
        coupon = couponData;
        return this.getCartData({ user_id: user_id });
      })
      .then((data) => {
        cartData = data;
        return this.getCouponDiscount(coupon, cartData);
      })
      .then((couponAmount) => this.compilePGOrder(pgid, cartData, coupon, couponAmount));
  }

  compilePGOrder(pgid, cartData, coupon, couponAmount) {
    return new Promise((resolve, reject) => {
      switch (parseInt(pgid)) {
        case parseInt(process.env.PG_RAZORPAY):
          this.generateRazorPayOrder(cartData, coupon, couponAmount)
            .then(resolve)
            .catch((err) => reject("Error in generating Razorpay Order"));
          break;
        case parseInt(process.env.PG_PAYPAL):
          this.generatePaypalOrder(cartData, coupon, couponAmount)
            .then(resolve)
            .catch((err) => reject("Error in generating Paypal Order"));
          break;
        default:
          reject("Payment Gateway not selected");
          break;
      }
    });
  }

  generateRazorPayOrder(cartData, coupon, couponAmount) {
    let order = {
      amount: parseInt(_.sum(_.map(cartData, (d) => d.price)) - couponAmount) * 100, // cents to USD
      currency: process.env.RAZORPAY_CURRENCY,
      receipt: `AD#${user_id}-${moment().format("YYYYMMDDHHmmss")}`,
    };

    let cartItems = [];

    cartData.forEach((d) => {
      let cres = JSON.parse(d.course_resources);
      cartItems.push({ id: d.id, course: parseInt(d.course_id), resources: cres.map((cr) => cr.id) });
      order.notes[`cart_${d.id}`] = d.name + "||" + cres.map((cr) => cr.type).join("||");
    });
    order.notes["cartItems"] = JSON.stringify(cartItems);

    if (couponAmount > 0) {
      order.notes["coupon_id"] = coupon.id;
      order.notes["coupon_code"] = coupon.coupon_code;
      order.notes["coupon_course_ids"] = coupon.course_ids;
      order.notes["coupon_type"] = coupon.coupon_type;
      order.notes["coupon_value"] = coupon.coupon_value;
      order.notes["coupon_amount"] = parseFloat(couponAmount).toFixed(2);
    }

    let rPay = new Razorpay({
      key_id: process.env.RAZORPAY_KEY,
      key_secret: process.env.RAZORPAY_SECRET,
    });
    return rPay.orders.create(order).then((orderData) => {
      return {
        success: true,
        data: {
          key: process.env.RAZORPAY_KEY,
          currency: orderData.currency,
          amount: orderData.amount,
          name: `Bundle Course - ${cartData.length}`,
          description: _.compact(_.map(orderData.notes, (v, i) => (i.indexOf("cart_") > -1 ? v : false))).join(" AND "),
          notes: orderData.notes,
          order_id: orderData.id,
        },
      };
    });
  }

  generatePaypalOrder(cartData, coupon, couponAmount) {
    paypal.configure({
      mode: process.env.PAYPAL_MODE,
      client_id: process.env.PAYPAL_CLIENT_ID,
      client_secret: process.env.PAYPAL_APP_SECRET,
    });

    let create_payment_json = {
      intent: "sale",
      payer: {
        payment_method: "paypal",
      },
      redirect_urls: {
        return_url: "/payment/success",
        cancel_url: "/payment/cancel",
      },
      transactions: [
        {
          item_list: {
            items: _.map(cartData, (cd) => ({
              name: cd.name,
              sku: cd.sku,
              price: parseFloat(cd.price).toFixed(2),
              currency: process.env.PAYPAL_CURRENCY,
              quantity: 1,
            })),
          },
          amount: {
            currency: process.env.PAYPAL_CURRENCY,
            total: parseFloat(_.sum(_.map(cartData, (cd) => cd.price))).toFixed(2),
          },

          description: _.compact(
            _.map(
              cartData,
              (cd) =>
                cd.name +
                "||" +
                JSON.parse(cd.course_resources)
                  .map((cr) => cr.type)
                  .join("||")
            )
          ).join(" AND "),
        },
      ],
    };

    if (parseFloat(couponAmount) > 0) {
      create_payment_json.transactions[0].item_list.items.push({
        name: `discount`,
        sku: coupon.coupon_code,
        price: `${parseFloat(couponAmount).toFixed(2)}`,
        currency: process.env.PAYPAL_CURRENCY,
        quantity: "1",
      });
    }

    console.log(create_payment_json.transactions[0].item_list.items);

    return new Promise((resolve, reject) => {
      paypal.payment.create(create_payment_json, function (error, payment) {
        if (error) {
          reject(error);
        } else {
          resolve(payment);
        }
      });
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
