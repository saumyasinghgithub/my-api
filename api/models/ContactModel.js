const _ = require("lodash");
const moment = require("moment");
const BaseModel = require("./BaseModel");
const Emailer = require("./EmailModel");
const TModel = require("./TrainerModel");
const SettingsModel = require("./SettingsModel");

class ContactModel extends BaseModel {
  table = "contact_us";
  pageLimit = 25;

  add(slug = "", data) {
    const fetchTrainerID = () => {
      return new Promise((resolve, reject) => {
        if (slug === "") {
          resolve(0);
        } else {
          new TModel.TrainerAbout()
            .bySlug(slug)
            .then((tData) => resolve(tData.user_id))
            .catch(() => resolve(0));
        }
      });
    };

    let trainer_id = 0;

    return fetchTrainerID()
      .then((tid) => (trainer_id = tid))
      .then(() => super.add({ ...data, trainer_id: trainer_id }))
      .then((res) => {
        if (res.success) {
          return new SettingsModel().getsiteData({ trainer_id: trainer_id }).then((res) => {
            return Emailer.sendEmail({
              to: _.get(res, "data.data.contact_email", process.env.CONTACT_FORM_EMAIL),
              subject: `Contact Form Submission`,
              html: this.contactFormEmail({
                ...data,
                name: data.name,
                phone: data.phone,
                email: data.email,
                message: data.message,
                settings: res.data.data,
              }),
            }).then(() => {
              return { success: true, message: "Your details have been submitted !" };
            });
          });
        } else {
          return res;
        }
      });
  }

  contactFormEmail(data) {
    let html = `<p>Hi ${data.name},</p>
    <p>Thank you submitting you the form</p>
    <p>AD team will connect shortly</p>
    <p>Your Form Data:</p>
    <p>Name: <b>${data.name}</b></p>
    <p>Phone: <b>${data.phone}</b></p>
    <p>Email: <b>${data.email}</b></p>
    <p>Your Queries: <b>${data.message}</b></p>
    Thank You.<br />
    By AD Admin`;

    return html;
  }

  delete(pkval) {
    return this.find(pkval).then((rec) => {
      if (rec) {
        return super.delete(pkval);
      }
    });
  }
}

module.exports = ContactModel;
