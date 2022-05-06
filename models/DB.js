const mysql = require('mysql');
const cfg = require('dotenv');
const path = require('path');
cfg.config({path: path.join(__dirname,'..','.env')});

class DB {

  conObj = null;
  clientDB = null;
  host = null;

  selectDB(host){
    return new Promise((resolve,reject) => {
      if(this.clientDB && this.host===host){
        resolve();
      }else{
        this.host = host;
      	this.conObj = null;
      
        const conn = mysql.createConnection({
          host: process.env.DB_HOST,
          port:process.env.DB_PORT,
          user: process.env.DB_USER,
          password: process.env.DB_PASS,
          database: process.env.DB_NAME        
        });

        conn.connect();
        conn.query('SELECT db_name FROM client_tbl WHERE domain_name=? LIMIT 1',[host],(err,res) => {                        
          if(!err){
            if(res.length === 1){
              this.clientDB = res[0].db_name;
              resolve();
            }else{
              reject("Invalid Client Access!");
            }
          }else{
            console.log(`Query failed with error: ${err}`);              
            reject(); // query failed
          }
        });
      }
    });

  }
  
  connect(){

    return new Promise((resolve,reject) => {

      if(this.conObj){   
     //this.conObj.connect();
        resolve();
      }else{
        this.conObj = mysql.createConnection({
          host: process.env.DB_HOST,
          port:process.env.DB_PORT,
          user: process.env.DB_USER,
          password: process.env.DB_PASS,
          database: this.clientDB        
        });
    
        this.conObj.connect();
        resolve();
        
      }
    });
  }

  disconnect(){
    this.conObj.end();
    this.conObj = null;
  }

  run(query,params=[]){

    return new Promise((resolve, reject) => {

      this.connect()
        .then( () => {
          this.conObj.query(query,params,(err,res) => {                        
            if(!err){
              resolve(res); // all ok
            }else{
              console.log(`Query failed with error: ${err}`);              
              reject(err); // query failed
            }
          });
        
      
        })
        .catch(reject)// connection failed
    });

  }

  getUpdateQuery(tblNm,data,idColNm){ 
    let idColVal = data[idColNm];
    delete data[idColNm];
    let data1 = Object.keys(data).join(' = ? , ') + ' = ? ';
    let str = `UPDATE ${tblNm} SET ${data1} where ${idColNm} = ?`;
    data[idColNm] = idColVal;
    console.log(str);
    return str;
  }
  
}

module.exports = (new DB());
