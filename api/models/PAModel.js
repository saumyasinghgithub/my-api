const _ = require('lodash');
const moment = require('moment');
const apiutils = require('../routes/apiutils');
const BaseModel = require('./BaseModel');

class PAModel extends BaseModel {

  table = "profile_attributes";
  pageLimit = 99999999999999; //=== Show all

  list(params){
    return super.list().then(res => {
      if(res.success && res.data.length > 0){
        res.data = res.data.map(rec => _.pick(rec,["id","title","parent_id"]));
        let data = _.filter(res.data,rec => rec.parent_id===0);
        //let data = res.data;
        //_.each(data, (d,i) => data[i]['children'] = _.filter(res.data,rec => rec.parent_id===d.id));

        _.each(data, (d, i) => {
          // Find all children of the current data element
          const children = _.filter(res.data, rec => rec.parent_id === d.id);
          
          // If there are any children, add them to the current data element
          if (children.length > 0) {
            data[i]['children'] = children;
            
            // For each child, find its children and add them
            _.each(children, (c, j) => {
              const grandChildren = _.filter(res.data, rec => rec.parent_id === c.id);
              
              if (grandChildren.length > 0) {
                children[j]['children'] = grandChildren;
                
                // Continue nesting _.each for more levels
                _.each(grandChildren, (gc, k) => {
                  // ...
                });
              }
            });
          }
        });
        
        res.data = data;
      }
      return res;
    });
  }



  

}

module.exports = PAModel;