const path = require('path');
const cfg = require('dotenv');
cfg.config({path: path.join(__dirname,'..','.env')});

const nodemailer = require('nodemailer');
const nodemailerSendgrid = require('nodemailer-sendgrid');
const _  = require('lodash');
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
      to: 'surojit19@gmail.com',
      subject: 'LOG FROM KS',
      html: 'Log coming in',
      ...opts
    };
    mailOptions.to= _.uniq(mailOptions.to.split(','));
    if(!_.isUndefined(mailOptions.cc)) {
      mailOptions.cc = _.filter(mailOptions.cc.split(','), c => !mailOptions.to.includes(c)).join(',');
    }
    mailOptions.to = mailOptions.to.join(',');

    return new Promise((resolve,reject) => {
    
      this.transport.sendMail(mailOptions, function(error, info){
        if (error) {
          console.log(error);
          reject(error);
        } else {
          resolve();
        }
      });
    
    });

  }

} 

module.exports = (new Emailer());