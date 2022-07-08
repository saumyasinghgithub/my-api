const _ = require('lodash');
const BaseModel = require('./BaseModel');
const fs = require('fs');
const path = require('path');
const slugify = require('slugify');

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

    console.log(iData);

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
    
    let frmdata = _.pick(data,['firstname','middlename','lastname','biography','certificates','trainings']);
    frmdata['user_id'] = user_id;
    return this.uploadImage(data, _.get(files,'profile_image',false),'profile')
    .then(fname => {
      frmdata['profile_image'] = fname;
      return this.uploadImage(data, _.get(files,'award_image',false), 'award');
    })
    .then(fname => {
      frmdata['award_image'] = fname;
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
      console.log(data);
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

module.exports = {TrainerAward, TrainerCalib, TrainerAcademic, TrainerExp, TrainerAbout, TrainerServices, TrainerCourse, TrainerCourseContent, TrainerCourseResource};