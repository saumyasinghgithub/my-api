const { ary } = require('lodash');
const _ = require('lodash');
const DBObject = require('./DB');

class BaseModel{

  db = null;
  pk = 'id';
  table = null;
  sortBy = 'id';
  sortDir = 'ASC';
  pageLimit = 10;
  
  constructor() {
    this.db = DBObject;
  }

  buildWhereClause(attrs){
    //== abstract function, need to be defined in calling classes
    if(_.get(attrs,'params.id',false)){
      attrs.sql += ` WHERE ${this.pk} = ?`;
      attrs.ary.push(attrs.params.id);
    }
    return attrs;
  }

  find(pkval){
    return this.db.run(`SELECT * FROM ${this.table} WHERE ${this.pk}=? LIMIT 1`,[pkval])
    .then(res => {
      if(res){
        return {...res[0]};
      }else{
        throw({message: "No Record found!"});
      }
    })
  }

  list(params) {
    //Fetch users from DB
    let sql = '';
    let ary = [];

    const attrs = this.buildWhereClause({params, sql, ary});
    sql = attrs.sql;
    ary = attrs.ary;
    

    let ret = { success: false };
    return this.db.run('SELECT COUNT(' + this.pk + ') as total FROM ' + this.table + sql,ary)
    .then(res => {
      if(res){
        ret['pageInfo'] = {
          hasMore: (res[0].total - parseInt(_.get(params,'start',0))) > parseInt(_.get(params,'limit',this.pageLimit)),
          total: res[0].total
        };
      }else{
        throw({message: "SQL failed!"});
      }
    })
    .then(() => {
      sql += ' ORDER BY ? ? LIMIT ?,?';
      ary.push(_.get(params,'sortBy',this.sortBy)); 
      ary.push(_.get(params,'sortDir',this.sortDir));
      ary.push(parseInt(_.get(params,'start',0)));
      ary.push(parseInt(_.get(params,'limit',this.pageLimit)));
      return this.db.run('SELECT * FROM ' + this.table + sql, ary);
    })
    .then(res => {
      // console.log(res);
      if (res) {
        ret['success'] = true;
        ret['data'] = res;
      } else {
        ret['error'] = 'No data found';
      }
      return ret;
    });
  }

  add(data){
    let sql = 'INSERT INTO ' + this.table;
    sql += '(' + _.keys(data).join(',') + ') VALUES ( ';
    sql += (new Array(_.keys(data).length)).fill('?').join(',') + ')';
    return this.db.run(sql,_.values(data))
    .then(res => {
      let ret = { success: false };
      if (res) {
        ret['success'] = true;
        ret['message'] = 'Record added, ID = ' + res.insertId;
      } else {
        ret['error'] = 'Failed to add Record.';
      }
      return ret;
    });
  }

  edit(data, pkval = ''){
    
    let sql = `UPDATE ${this.table} SET`;

    sql += _.keys(data).map( k => ` ${k} = ?`).join(',');

    let ary = _.values(data);

    if(pkval!=''){
      sql += ` WHERE ${this.pk} = ?`;
      ary.push(pkval);
    }
    return this.db.run(sql,ary)
    .then(res => {
      let ret = { success: false };
      if (res) {
        ret['success'] = true;
        ret['message'] = 'Record updated';
      } else {
        ret['error'] = 'Failed to update Record.';
      }
      return ret;
    });


  }

  delete(pkval){
    return this.db.run(`DELETE FROM ${this.table} WHERE ${this.pk} = ?`,[pkval])
    .then(res => {
      let ret = { success: false };
      if (res.affectedRows > 0) {
        ret['success'] = true;
        ret['message'] = 'Record Deleted';
      } else {
        ret['error'] = 'Failed to update Record.';
      }
      return ret;
    });
  }

}

module.exports = BaseModel;