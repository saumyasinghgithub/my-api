const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const moment = require('moment');
const _ = require('lodash');
const DBObject = require('../models/DB');

const canAccess = (req) => {
  return new Promise((resolve,reject) => {
    let apikey = req.header('x-api-key');
    const isApiValid = bcrypt.compareSync(process.env.JWTSECRET,apikey);
    if(isApiValid){
      DBObject.selectDB(req.headers.host)
      .then(resolve)
      .catch(reject);
    }else{
      reject("API Key Invalid!");
    }
  });
}

const genToken = (payload) => {  
  try{
    const token = jwt.sign(payload, process.env.JWTSECRET,  { algorithm: 'HS256'});
    return token;    
  }
  catch(e){
    console.log("Token Generation Error: " , e);
    return e;
  }
}

const verifyToken = (req,return_token_as_object = false) => {
  const ret = {success: false, message: "Invalid Access!"}; 
  try{
    const token = req.header('token'); 
       
    if(token && !_.isNull(token) && !_.isEmpty(token)){           
      let userData = jwt.verify(token, process.env.JWTSECRET);  
          
      if(_.get(userData,'id',false)){
        if(moment(userData.validTill).isAfter(moment())){    
          ret['message'] = 'Token expired, please login again to continue!'; 
         }else{
          ret['success'] = true;
          ret['data'] = return_token_as_object ? userData : userData.id;
       }     
      }
    }
    return ret;
  }catch(e){
    console.log(e);
    ret['message'] = 'Err Occured.' + e;
    return ret;
  }  
};

module.exports = {
  canAccess,
  genToken,
  verifyToken
};