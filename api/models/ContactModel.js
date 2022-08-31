const _ = require('lodash');
const moment = require('moment');
const BaseModel = require('./BaseModel');
const Emailer = require('./EmailModel');



class ContactModel extends BaseModel {

  table = "contact_us";
  pageLimit = 10;

  add(data){
    return super.add(data)
    .then(res => {
      if(res.success){
          return Emailer.sendEmail({
            to: data.email,
            subject: `Contact Form Submission`,
            html: this.contactFormEmail({...data, name: data.name, phone: data.phone, email:data.email, message:data.message})
          })
          .then(() => {
            return res;
          })
        }else{
          return res;
        }
    })
  }

  contactFormEmail(data){
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

}


module.exports = ContactModel;