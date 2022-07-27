const _ = require('lodash');
const BaseModel = require('./BaseModel');
const fs = require('fs');
const path = require('path');
const slugify = require('slugify');
const PAModel = require('./PAModel');

class TrainerBase extends BaseModel {

  addMulti(data){
    return new Promise((resolve,reject) => {
      let idx = 0;
      const addMe = () => {
        if(idx >= data.length){
          resolve(idx);
        }else{
          this.add(data[idx++])
          .then(res => {
            if(res.success){
              addMe();
            }else{
              reject(res);
            }
          })
          .catch(reject);
        }
      }

      if(data.length==0){
        resolve(0);
      }else{
        addMe();
      }

    });
  }

  deleteImage(folder,fname){
    let fpath = path.resolve('public','uploads',folder,fname);
    if(!_.isEmpty(fname) && fs.existsSync(fpath)){
      fs.unlinkSync(fpath);
    }
  }

  uploadImage(data, file,ftype){
    return new Promise((resolve,reject) => {
      if(!file){
        resolve(_.get(data,`old_${ftype}_image`,'')); 
      }
      if(_.get(file,'size',0) > 0){
        let fname = ftype + '_' + data.id + '_' + file.name;
        let fpath = path.resolve('public','uploads',ftype,fname);
        file.mv(fpath, err => {
          if(err){
            reject(err);
          }else{
            this.deleteImage(ftype,_.get(data,`old_${ftype}_image`,''));
            resolve(fname);
          }
        })
      }else{
        resolve(_.get(data,`old_${ftype}_image`,''));
      }
    })
  }

}

class TrainerCalib extends TrainerBase {

  table = "trainer_calibrations";
  pageLimit = 10;
  
  edit(data,user_id){

    let iData = [];
    
    const getpa_id =(k) => k.substring(6,k.indexOf(']'));

    _.each(data, (v,k) => {
      if(_.isArray(v)){
        _.each(v, v1 => iData.push({
          'user_id': user_id,
          'pa_id': getpa_id(k),
          'pa_value': v1
        }));
      }else{
        iData.push({
          'user_id': user_id,
          'pa_id': getpa_id(k),
          'pa_value': v
        });
      }
    });

    return this.deleteWhere({'user_id': user_id})
    .then(res => this.addMulti(iData))
    .then(data => ({
      success: true,
      message: 'Data saved!'
    }));
    
  }

  
}

class TrainerAward extends TrainerBase {

  table = "trainer_awards";

  edit(data,user_id){

    let iData = [];

    _.each(data.year, (v,k) => {
      if(v!=='' && data.award[k]!=''){
        iData.push({
          'user_id': user_id,
          'award': data.award[k],
          'organisation': data.award[k],
          'year': v,
          'url': data.url[k]
        });
      }
      
    });

    return this.deleteWhere({'user_id': user_id})
    .then(res => this.addMulti(iData))
    .then(data => ({
      success: true,
      message: 'Data saved!'
    }));
    
  }
}

class TrainerAcademic extends TrainerBase {

  table = "trainer_academic";

  edit(data,user_id){

    let iData = [];

    _.each(data.year, (v,k) => {
      if(v!=='' && data.qualification[k]!=''){
        iData.push({
          'user_id': user_id,
          'qualification': data.qualification[k],
          'year': v
        });
      }
      
    });

    return this.deleteWhere({'user_id': user_id})
    .then(res => this.addMulti(iData))
    .then(data => ({
      success: true,
      message: 'Data saved!'
    }));
    
  }
}

class TrainerExp extends TrainerBase {

  table = "trainer_exp";

  edit(data,user_id){
    let iData = [];

    _.each(data.location, (v,k) => {
      if(v!=='' && data.company[k]!=''){
        iData.push({
          'user_id': user_id,
          'company': data.company[k],
          'location': v
        });
      }
      
    });

    return this.deleteWhere({'user_id': user_id})
    .then(res => this.addMulti(iData))
    .then(data => ({
      success: true,
      message: 'Data saved!'
    }));
    
  }

}

class TrainerAbout extends TrainerBase {

  table = "trainer_about";

  

  edit(data,files,user_id){
    
    let frmdata = _.pick(data,['firstname','middlename','lastname','slug','biography','trainings']);
    frmdata['user_id'] = user_id;
    const spath = _.lowerCase(frmdata.firstname + ' ' + frmdata.lastname + ' ' + user_id);
    console.log(spath);
    frmdata['slug'] = slugify(spath,{remove: /[*#+~.()'"!:@]/g},{lower: true});
    return this.uploadImage(data, _.get(files,'profile_image',false),'profile')
    .then(fname => {
      frmdata['profile_image'] = fname;
      return this.uploadImage(data, _.get(files,'award_image',false), 'award');
    })
    .then(fname => {
      frmdata['award_image'] = fname;
      return this.uploadImage(data, _.get(files,'base_image',false), 'base');
    })
    .then(fname => {
      frmdata['base_image'] = fname;
      if(data.id > 0){
        return super.edit(frmdata, data.id);
      }else{
        return super.add(frmdata);
      }
    });

  }
}

class TrainerServices extends TrainerBase {

  table = "trainer_services";

  edit(data,files,user_id){
    
    let frmdata = _.pick(data,['service_offer','consultancy','coaching']);
    frmdata['user_id'] = user_id;
    return this.uploadImage(data, _.get(files,'service_image',false),'service')
    .then(fname => {
      frmdata['service_image'] = fname;
      if(parseInt(data.id) > 0){
        return super.edit(frmdata, data.id);
      }else{
        return super.add(frmdata);
      }
    });

  }
}

class TrainerCourse extends TrainerBase {

  table = "courses";

  edit(data,files,user_id){
    
    let frmdata = _.pick(data,['user_id','name', 'sku','price','short_description','description','learn_brief','requirements','stock_qnty','course_image','level','language','duration','lectures','media']);
    frmdata['user_id'] = user_id;
    frmdata['slug'] = slugify(frmdata.name,{remove: /[*#+~.()'"!:@]/g},{lower: true});
    return this.uploadImage(data, _.get(files,'course_image',false),'courses')
    .then(fname => {
      frmdata['course_image'] = fname;
      if(parseInt(data.id) > 0){
        return super.edit(frmdata, data.id);
      }else{
        return super.add(frmdata);
      }
    });
  }

  delete(pkval){
    return this.find(pkval)
    .then(rec => { 
      if(!_.isEmpty(_.get(rec, 'course_image', ''))) {
        this.deleteImage('courses', rec.course_image);
      }
    })
    .then(()=> super.delete(pkval));
    }
  }

class TrainerCourseContent extends TrainerBase {

  table = "course_content";

  edit(data,files){
    
    let frmdata = _.pick(data,['course_id','title','description','embed_resource','video','duration','lecture']);
    return this.uploadImage(data, _.get(files,'video',false),'content')
    .then(fname => {
      frmdata['video'] = fname;
      if(parseInt(data.id) > 0){
        return super.edit(frmdata, data.id);
      }else{
        return super.add(frmdata);
      }
    });
  }

  delete(pkval){
    return this.find(pkval)
    .then(rec => { 
      if(!_.isEmpty(_.get(rec, 'video', ''))) {
        this.deleteImage('content', rec.video);
      }
    })
    .then(()=> super.delete(pkval));
    }
  }

class TrainerCourseResource extends TrainerBase {

  table = "course_resources";

  edit(data){
    
    let frmdata = _.pick(data,['course_id','type','name','price']);
    
      if(parseInt(data.id) > 0){
        return super.edit(frmdata, data.id);
      }else{
        return super.add(frmdata);
      }
  }

  delete(pkval){
    return this.find(pkval)
    .then(rec => { 
      if(rec){
        return super.delete(pkval);
      }
    })
  }
}

class TrainerSearch extends TrainerBase{

  table = "trainer_calibrations";

  search(params){
    let ret = {success: false, message: "Invalid Search Criteria"};
    let user_ids = [];
    if(_.get(params,'calibs',false)){

      let calibs = JSON.parse(params.calibs);
      params.whereStr = _.join(_.map(calibs, (pval,pk) => `(pa_id=${parseInt(pk)} AND pa_value=${parseInt(pval)})`),' OR ');

    }    
    return this.list({...params,limit: 999999999, fields: 'DISTINCT(user_id) as user_id'})
    .then(res => {
      user_ids = res.data.map(d => d.user_id);
      return this.fetchAbout(params, user_ids);
    }).then(about => {
      ret = {success: about.success, data: about.data, pageInfo: about.pageInfo};
      return this.fetchCalibs(user_ids,params.paCalibs);
    }).then(calibs => {
      ret.data = ret.data.map(ud => ({...ud, calibs: _.filter(calibs,{user_id: ud.user_id}).map(c => _.omit(c,'user_id'))}))
      return this.fetchCourses(user_ids);
    }).then(courses => {
      ret.data = ret.data.map(ud => ({...ud, courses: _.omit(_.filter(courses,{user_id: ud.user_id})[0],'user_id')}))
      return this.fetchCourseResources(_.flattenDeep(courses.map(uc => uc.courses.map(c => c.course_id))))
      .then(cres => {
        ret.data = ret.data.map(ud => ({...ud, courses: {...ud.courses, courses: ud.courses.courses.map(udc => ({...udc, resources: _.filter(cres.data,{course_id: udc.course_id})}))}}))
        return ret;
      })
    });
  }

  fetchAbout(params, user_ids){
    return (new TrainerAbout()).list({
      ...params,
      whereStr: `user_id IN (${user_ids.join(',')})`, 
      fields: 'firstname,lastname,base_image,profile_image,user_id'
    });
  }

  fetchCalibs(user_ids,calibs){
    return (new TrainerCalib()).list({
      limit: 99999, 
      whereStr: `user_id IN (${user_ids.join(',')}) AND pa_id IN (${calibs})`, 
      fields: 'user_id,pa_id,pa_value'
    })
    .then(res => {
      let userCalibs = [...res.data];
      return (new PAModel()).list({
        limit: 99999, 
        whereStr: `id IN (${res.data.map(d => d.pa_value).join(',')}) AND active=1`, 
        fields: 'id,title'
      })
      .then(res1 => {
        userCalibs = userCalibs.map(uc => ({...uc, "pa_value": _.find(_.find(res1.data,{id: uc.pa_id}).children,{id: uc.pa_value}).title}));
        return userCalibs;
      })
      
    })
  }

  fetchCourses(user_ids){
    let uidx= 0;
    let userCourses = user_ids.map(uid => ({user_id: uid, courses: [], total: 0}));
    return new Promise((resolve,reject) => {
      const iterate = () => {
        if(uidx >= user_ids.length){
          resolve(userCourses);
        }else{
          let user_id = user_ids[uidx++];
          this.fetchUserCourses(user_id)
          .then(uc => {
            let idx = _.findIndex(userCourses,{user_id: user_id});
            userCourses[idx].courses = uc.data.map(d => _.omit(d,'user_id'));
            userCourses[idx].total = uc.pageInfo.total;
          })
          .finally(iterate);
        }
      };

      iterate();

    });
  }

  fetchUserCourses(user_id){
    return (new TrainerCourse()).list({
      start: 0,
      limit: 4,
      sortBy: 'created_at',
      sortDir: 'DESC',
      whereStr: `user_id=${parseInt(user_id)}`, 
      fields: 'id as course_id,user_id,name,course_image,slug,price'
    });
  }

  fetchCourseResources(course_ids){
    return (new TrainerCourseResource()).list({
      start: 0,
      limit: 9999999,
      whereStr: `course_id IN (${course_ids.join(',')})`,
      fields: 'id as resource_id,course_id,name,type,price'
    });
  }

}

module.exports = {TrainerAward, TrainerCalib, TrainerAcademic, TrainerExp, TrainerAbout, TrainerServices, TrainerCourse, TrainerCourseContent, TrainerCourseResource, TrainerSearch};