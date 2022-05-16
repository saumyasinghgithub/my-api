const path = require('path');
const cfg = require('dotenv');
cfg.config({path: path.join(__dirname,'..','.env')});

const nodemailer = require('nodemailer');
const nodemailerSendgrid = require('nodemailer-sendgrid');

class Emailer{

  transport = null;
  
  constructor(){
    this.transport = nodemailer.createTransport(
      nodemailerSendgrid({apiKey: process.env.SENDGRID_API_KEY})
    );
  }

  sendEmail(opts={}){

    var mailOptions = {
      from: process.env.DEFAULT_EMAIL_FROM,
      bcc: process.env.DEFAULT_EMAIL_TO,
      to: 'surojit19@gmail.com',
      subject: 'LOG FROM KS',
      html: 'Log coming in',
      ...opts
    };

    return new Promise((resolve,reject) => {
    
      this.transport.sendMail(mailOptions, function(error, info){
        if (error) {
          reject(error);
        } else {
          resolve(info.response);
        }
      });
    
    });

  }

} 

module.exports = (new Emailer());