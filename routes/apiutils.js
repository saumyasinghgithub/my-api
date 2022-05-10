const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const moment = require('moment');
const _ = require('lodash');

const canAccess = (req) => {
  return new Promise((resolve,reject) => {
    try{
      if(!_.get(req,'headers.x-api-key',false)) throw("No API Key found!");

      let apikey = req.header('x-api-key');
      isValid = bcrypt.compareSync(process.env.JWTSECRET,apikey);
      if(isValid){
        resolve();
      }else{
        throw("Invalid API Key!");
      }
    }catch(e){
      reject(e);
    }
  })
  
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

const routeWrapper = (func) => {
  return (req,res) => {    
    let ret = {success: false, message: "Invalid Access"};
    canAccess(req)
    .then(() => func(req))
    .then(rec => ret = {...ret,...rec})
    .catch(err => ret = {...ret, message: _.get(err,'message',err)})
    .finally(() => res.json(ret))
  };
}

module.exports = {
  canAccess,
  genToken,
  verifyToken,
  routeWrapper
};