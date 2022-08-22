const axios = require('axios');
const _ = require('lodash');
const moment = require('moment');

//=== Base class
class MoodleAPIBase{

  token=null;
  api=null;
  domain=null;
  username = null;
  password = null;

  constructor(domain = null){
      this.domain = 'http://demo.knowledgesynonyms.com/moodle';//domain;     
      this.username='apiuser';
      this.password='APIUser@1234';   
      this.api = `${this.domain}/webservice/rest/server.php`;
  }

  setToken(token){
      this.token = token;
  }

  getToken(){
      return this.token;
  }

  login(){     
    
    return new Promise((resolve,reject) => {
      if(this.getToken()){
        resolve();
      }else{
        let url = `${this.domain}/login/token.php?service=moodle_api`;  
        console.log(`username=${this.username}&password=${this.password}`);
        return axios.post(url,`username=${this.username}&password=${this.password}`)
        .then(res => {
          if(_.get(res,'data.token',false)){
            this.setToken(res.data.token);
            resolve();
          }else{
            reject("Invalid Login");
          }
        });
      }
    });
  }

  hit(func,params){

      /// REST CALL
      return this.login()
      .then(() => {
        let url = `${this.api}?moodlewsrestformat=json&wstoken=${this.getToken()}&wsfunction=${func}`;
        //let url = this.api;
        //params = params + `&moodlewsrestformat=json&wstoken=${this.getToken()}&wsfunction=${func}`;
        console.log(url,params);
        return axios.post(url,params).then(console.log)
      });
  }

}



class MoodleAPI extends MoodleAPIBase{

  createUser(user){
    /*                
      user = {
        'username': "testing",
        'password': "Testing@2020",
        'firstname': "TestSuro",
        'lastname': "Basu",
        'email': "surojit99@gmail.com",
        'auth': "manual"
      };
    */
    //let params = _.map(user, (v,k) => `users[0][${k}]=${v}`).join('&');

    let params = `users=[${JSON.stringify(user)}]`;
    return this.hit('core_user_create_users',params);
}

}



module.exports = MoodleAPI;