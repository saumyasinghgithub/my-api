const _ = require('lodash');
const BaseModel = require('./BaseModel');
const fs = require('fs');
const path = require('path');
const slugify = require('slugify');
const PAModel = require('./PAModel');
const CourseModel  = require('./CourseModel');
const MoodleAPI = require('./MoodleAPI');


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

  myTotalStudents(trainer_id){
    return this.db.run('SELECT count(user_id) total FROM student_enrollments WHERE course_id IN (select id from courses where user_id=?) GROUP BY user_id',[trainer_id])
    .then(res => _.get(res,'0.total',0))
    .catch(err => 0);
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
    const spath = frmdata.firstname + ' ' + frmdata.lastname + ' ' + user_id;
    frmdata['slug'] = slugify(spath,{remove: /[*#+~.()'"!:@]/g, lower: true});
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
  
  bySlug(slug) {
    return this.list({where:{slug:slug}, limit: 1})
    .then(res => _.get(res, 'data.0', false));
  }

  myFavs({start,limit,user_id}){
    return this.list({whereStr: `user_id IN (SELECT trainer_id FROM favorites WHERE user_id=${user_id})`, start: start, limit: limit});
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

class TrainerKnowledge extends TrainerBase {

  table = "trainer_knowledge";

  edit(data,files,user_id){
    
    let frmdata = _.pick(data,['about_knowledge']);
    frmdata['user_id'] = user_id;
    return this.uploadImage(data, _.get(files,'knowledge_image',false),'knowledge')
    .then(fname => {
      frmdata['knowledge_image'] = fname;
      if(parseInt(data.id) > 0){
        return super.edit(frmdata, data.id);
      }else{
        return super.add(frmdata);
      }
    });

  }
}

class TrainerCommunity extends TrainerBase {

  table = "trainer_community";

  edit(data,files,user_id){
    
    let frmdata = _.pick(data,['about_community', 'youtube_community']);
    frmdata['user_id'] = user_id;
    return this.uploadImage(data, _.get(files,'community_image',false),'community')
    .then(fname => {
      frmdata['community_image'] = fname;
      if(parseInt(data.id) > 0){
        return super.edit(frmdata, data.id);
      }else{
        return super.add(frmdata);
      }
    });

  }
}

class TrainerLibrary extends TrainerBase {

  table = "trainer_library";

  edit(data,files,user_id){
    
    let frmdata = _.pick(data,['about_library']);
    frmdata['user_id'] = user_id;
    return this.uploadImage(data, _.get(files,'library_image',false),'library')
    .then(fname => {
      frmdata['library_image'] = fname;
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
    
    let frmdata = _.pick(data,['user_id','name', 'sku','short_description','description','learn_brief','requirements','stock_qnty','course_image','level','language','duration','lectures']);
    frmdata['user_id'] = user_id;
    frmdata['slug'] = slugify(frmdata.name,{remove: /[*#+~.()'"!:@]/g},{lower: true});
    return this.uploadImage(data, _.get(files,'course_image',false),'courses')
    .then(fname => {
      frmdata['course_image'] = fname;
      if(parseInt(data.id) > 0){
        return super.edit(frmdata, data.id).then(editRes => {
          if(editRes.success){
            return this.updateCourseInMoodle({...data, user_id: user_id}).then(() => editRes);
          }else{
            return editRes;
          }
        });
      }else{
        return super.add(frmdata);
      }
    });

  }

  extractUserMoodleId(user_id){    
    return this.db.run(`SELECT moodle_id FROM users WHERE id=?`,user_id)
    .then(res => parseInt(_.get(res,'0.moodle_id',0)))
  }


  createCourseInMoodle(data){
    let course_mid = 0;
    let mAPIObj = new MoodleAPI();
    return mAPIObj.createCourse({
      fullname: data.name, 
      shortname: data.sku, 
      summary: data.short_description
    }).then(res => {
      course_mid = parseInt(_.get(res,'[0].id',0));
      if(course_mid > 0){
        return super.edit({moodle_id: course_mid}, data.id).then(() => {
          return res;
        });
      }
      return res;
    }).then(() => {
      if(course_mid > 0){
        return this.extractUserMoodleId(data.user_id)
        .then(user_mid => {
          if(user_mid > 0){           
            return mAPIObj.setCourseUser({
              userid: user_mid,
              courseid: course_mid,
              roleid: parseInt(process.env.MOODLE_TEACHER_ROLE)
            });
          }
        })
      }
    })
  }


  updateCourseInMoodle(data){
    if(parseInt(_.get(data,'mid',0)) > 0){
      return (new MoodleAPI()).updateCourse({
        id: data.mid, 
        fullname: data.name, 
        shortname: data.sku, 
        summary: data.short_description
      });
    }else{
      console.log("adding course", data.name);
      return this.createCourseInMoodle(data);
    }
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

  bySlug(slug){
    return (new TrainerAbout()).bySlug(slug)
    .then(about => {
      if(about){
        return (new CourseModel()).getByTrainer(about.user_id)
        .then(courses => ({trainer: about, courses: courses}));
      }else{
        return {trainer: false, courses: []}
      }
    });
  }


  loadStats(trainer_id){
    let stats = [];
    return new Promise((resolve,reject) => {
      return this.db.run(`SELECT SUM(price) total FROM cart WHERE status='paid' AND course_id IN (SELECT id FROM courses where user_id=?)`,[trainer_id])
      .then(res => {
        stats.push(parseInt(_.get(res,'0.total',0)));
        return this.db.run(`select SUM(1) as total, SUM(IF(exists(SELECT course_id FROM student_enrollments WHERE course_id=c.id),1,0)) sold FROM courses as c WHERE c.user_id=?`,[trainer_id])
      })
      .then(res => {
        stats.push(parseInt(_.get(res,'0.sold',0))/parseInt(_.get(res,'0.total',0))*100);
        return this.db.run(`SELECT COUNT(DISTINCT user_id) as students FROM student_enrollments WHERE course_id IN (SELECT id FROM courses where user_id=?)`,[trainer_id])
      })
      .then(res => {
        stats.push(parseInt(_.get(res,'0.students',0)));
        return this.db.run(`SELECT COUNT(id) orders FROM cart WHERE status='paid' AND course_id IN (SELECT id FROM courses where user_id=?)`,[trainer_id])
      }).then(res => {
        stats.push(parseInt(_.get(res,'0.orders',0)));
        resolve({success: true, stats: stats});
      });

    });
  }

  totalCourses(trainer_id){ 

    return this.db.run('SELECT count(id) as total FROM courses where user_id=?',[trainer_id])
    .then(res => _.get(res,'0.total',0))
    .catch(err => 0);

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

  profile({slug}){
    
    let tData = {};
    let whereParams = {'where' : {'slug': slug}};
    return (new TrainerAbout()).list(whereParams)
    .then(({data}) => {
      tData.about=_.get(data,'0',{});
      if(_.get(tData,'about.id',false)){
        whereParams = {'where' : {'user_id': tData.about.user_id}};
        return (new TrainerRating()).getRatingByTrainer(tData.about.user_id);
      }else{
        throw {message: "No such trainer found"};
      }
    })
    .then((rating) => {
      tData.rating=rating;
      return this.myTotalStudents(tData.about.user_id);
    })
    .then(totalStudent => {
      tData.total = {students: totalStudent, courses: 0};
      return (new TrainerCourse()).totalCourses(tData.about.user_id);
    })
    .then(totalCourse => {
      tData.total.courses = totalCourse;
      return (new TrainerAward()).list(whereParams);
    })
    .then(({data}) => {
      tData.awards = data;
      return (new TrainerServices()).list(whereParams);
    })
    .then(({data}) => {
      tData.service = _.get(data,'0',{});
      return (new TrainerCalib()).list(whereParams);
    })
    .then(({data}) => {
      tData.calibs = data;
      return (new TrainerAcademic()).list(whereParams);
    })
    .then(({data}) => {
      tData.academics = data;
      return (new TrainerExp()).list(whereParams);
    })
    .then(({data}) => {
      tData.experiences = data;
      return (new TrainerKnowledge()).list(whereParams);
    })
    .then(({data}) => {
      tData.knowledge = data;
      return (new TrainerBlog()).list({...whereParams,sortBy: 'updated_at', sortDir: 'DESC'});
    })
    .then(({data}) => {
      tData.blogs = parseInt(_.get(data,'length',0)) > 0 ? data : [];
      return (new TrainerCommunity()).list(whereParams);
    })
    .then(({data}) => {
      tData.community = data;
      return (new TrainerLibrary()).list(whereParams);
    })
    .then(({data}) => {
      tData.library = _.get(data,'0',{});
      return (new TrainerSocial()).list(whereParams);
    })
    .then(({data}) => {
      tData.social = _.get(data,'0',{});
      return (new CourseModel()).getByTrainer(tData.about.user_id);
    })
    .then(courses =>  {
      tData.courses = courses;
      return tData;
    });
  }

  search(params){
    let ret = {success: false, message: "Invalid Search Criteria"};
    let all_user_ids = [], user_ids = [];
    
    params.whereStr = `user_id IN (SELECT id FROM users where id = user_id AND active = 1)`;

    if(_.get(params,'calibs',false) && params.calibs!="{}"){
      let calibs = JSON.parse(params.calibs);
      calibs = _.map(calibs, (pval,pk) => `pa_id=${parseInt(pk)} AND pa_value=${parseInt(pval)}`);
      if(calibs.length > 1){
        params.whereStr += ` AND ((` + _.join(calibs,') OR (') + '))';
      }else{
        params.whereStr += ` AND ` + calibs[0];
      }
      
    }

    return this.list({...params, start: 0, limit:9999999, fields: 'DISTINCT(user_id) as user_id'})
    .then(res => {
      params['start'] = parseInt(_.get(params,'start',0));
      params['limit'] = parseInt(_.get(params,'limit',this.pageLimit));
      all_user_ids = res.data.map(d => d.user_id);
      user_ids = all_user_ids.slice(params.start,params.start+params.limit);
      ret = {success:true, favTrainers: [], pageInfo: {
        hasMore: all_user_ids.length - params.start > params.limit, 
        total: all_user_ids.length
      }};
      params.start = 0; //== since we already sliced users
      return this.fetchAbout(params, user_ids);
    }).then(about => {
      ret = {...ret, data: about.data};
      if(params.user_id){
        return this.favTrainers(params.user_id,user_ids)
        .then((favTrainers) => {
          ret = {...ret, favTrainers: favTrainers};
           return this.fetchCalibs(user_ids,params.paCalibs);
        });
      }else{
        return this.fetchCalibs(user_ids,params.paCalibs);
      }
    }).then(calibs => {
      ret.data = ret.data.map(ud => ({...ud, calibs: _.filter(calibs,{user_id: ud.user_id}).map(c => _.omit(c,'user_id'))}))
      return this.fetchRatings(user_ids);
    }).then(ratings => {
      ret.data = ret.data.map(ud => ({...ud, rating: _.omit(ratings[ud.user_id],'trainer_id')}));
      return this.fetchCourses(user_ids);
    }).then(courses => {
      ret.data = ret.data.map(ud => ({...ud, courses: _.omit(_.filter(courses,{user_id: ud.user_id})[0],'user_id')}))
      return this.fetchCourseResources(_.flattenDeep(courses.map(uc => uc.courses.map(c => c.course_id))))
      .then(cres => {
        ret.data = ret.data.map(ud => ({...ud, courses: {...ud.courses, courses: ud.courses.courses.map(udc => ({...udc, resources: _.filter(cres.data,{course_id: udc.course_id})}))}}));

        if(parseInt(params.loadStats)===1){
          return this.searchStats(all_user_ids)
          .then(stats =>{
            ret.stats = stats;
            return ret;
          });          
        }else{
          return ret;
        }

      })
      
    });
  }

  favTrainers(user_id, trainer_ids){
    const sql = `SELECT trainer_id FROM favorites WHERE user_id=${user_id} AND trainer_id IN (${trainer_ids.join(',')})`;
    return this.db.run(sql,[])
    .then(res => {
      return _.get(res,'length',0) > 0 ? res.map(r => r.trainer_id) : [];
    });
  }

  fetchAbout(params, user_ids){
    return (new TrainerAbout()).list({
      ...params,
      whereStr: `user_id IN (${user_ids.join(',')})`, 
      fields: 'firstname,lastname,base_image,profile_image,user_id,slug'
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

  fetchRatings(user_ids){
    return (new TrainerRating()).getRatingByTrainers(user_ids);
  }

  fetchUserCourses(user_id){
    return (new TrainerCourse()).list({
      start: 0,
      limit: 3,
      sortBy: 'created_at',
      sortDir: 'DESC',
      whereStr: `user_id=${parseInt(user_id)}`, 
      fields: 'id as course_id,user_id,name,course_image,slug'
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
 
  searchStats(all_user_ids){
    
    let stats = {allTrainers:0, allCourses:0, trainers: all_user_ids.length, courses: 0};
      return this.db.run(`SELECT COUNT(id) AS allTrainers FROM users WHERE role_id = 4 AND active=1`)
      .then(res1 => {
      
        stats.allTrainers = (parseInt(_.get(res1, '0.allTrainers', 0)));
        return this.db.run(`SELECT COUNT(id) AS allCourses FROM courses`);
      })
      .then(res2 => {
        stats.allCourses = (parseInt(_.get(res2, '0.allCourses', 0)));
        return this.db.run(`SELECT COUNT(id) AS total FROM courses WHERE user_id IN (${all_user_ids.join(',')})`);
      })
      .then(res3 => {
        stats.courses = (parseInt(_.get(res3, '0.total', 0)));
        return this.db.run(`SELECT 
        SUM(IF(type='PPT' || type='pdf',1,0)) as allBooks, 
        SUM(IF(type='video',1,0)) as allVideos, 
        SUM(IF(type='audio',1,0)) as allAudios 
        FROM course_resources`);
      })
      .then(res4 => {
        stats = {...stats, ..._.get(res4,'0',{})};

        return this.db.run(`SELECT 
          SUM(IF(type='PPT' || type='pdf',1,0)) as books, 
          SUM(IF(type='video',1,0)) as videos, 
          SUM(IF(type='audio',1,0)) as audios 
          FROM course_resources WHERE course_id IN 
          (SELECT id AS total FROM courses WHERE user_id IN (${all_user_ids.join(',')}))`);
      })
      .then(res5 => {
        stats = {...stats, ..._.get(res5,'0',{})};
        return stats;
      })
      

  }

}

class TrainerBlog extends TrainerBase {

  table = "blogs";
  updated_at = true;

  edit(data,files,user_id){
    
    let frmdata = _.pick(data,['user_id','name','slug','short_description','description','blog_image', 'blog_banner']);
    frmdata['user_id'] = user_id;
    frmdata['slug'] = slugify(frmdata.name,{remove: /[*#+~.()'"!:@]/g, lower: true});
    return this.uploadImage(data, _.get(files,'blog_image',false),'blog')
    .then(fname => {
      frmdata['blog_image'] = fname;
      return this.uploadImage(data, _.get(files,'banner_image',false), 'banner');
    })
    .then(fname => {
      frmdata['banner_image'] = fname;
      if(parseInt(data.id) > 0){
        return super.edit(frmdata, data.id);
      }else{
        return super.add(frmdata);
      }
    });

  }

  bySlug(slug) {
    return this.list({where:{slug:slug}, limit: 1})
    .then(res => _.get(res, 'data.0', false));
  }

  delete(pkval){
    return this.find(pkval)
    .then(rec => { 
      if(!_.isEmpty(_.get(rec, 'blog_image', ''))) {
        this.deleteImage('blogs', rec.blog_image);
      }
    })
    .then(()=> super.delete(pkval));
  }

}

class TrainerRating extends TrainerBase{
  table = "trainer_rating";

  getRatingByTrainer(trainer_id){
    return this.db.run('SELECT AVG(rating) as rating,COUNT(user_id) as ratings FROM ' + this.table + ' WHERE trainer_id=?',[trainer_id])
      .then(res => ({
        rating: _.isNull(res[0].rating) ? 0 : res[0].rating,
        ratings: _.get(res,'0.ratings',0)
      }))
      .catch(err => ({rating:0, ratings: 0}));
  }

  getRatingByTrainers(ids){
    let ratings = {};
    ids.forEach(id => ratings[id]={rating:0, ratings: 0});
    return new Promise((resolve,reject)=>{
      this.db.run('SELECT trainer_id,AVG(rating) as rating,COUNT(id) as ratings FROM  ' + this.table + ' WHERE trainer_id IN ('+ids.join(',')+') GROUP BY trainer_id')
      .then(res => {
        res.forEach(r => ratings[r.trainer_id] = {
          rating: _.isNull(r.rating) ? 0 : r.rating,
          ratings: _.get(r,'ratings',0)
        });
      })
      .catch(err => {/* do nothing */})
      .finally(() => resolve(ratings))
    });
  }

  save(ratingObj){
    return this.deleteWhere({user_id: ratingObj.user_id, trainer_id: ratingObj.trainer_id})
    .then(() => this.add(ratingObj))
    .then(() => this.getRatingByTrainer(ratingObj.trainer_id))
    .then(rating => ({success: true, rating: rating}))
  }
}

class TrainerSocial extends TrainerBase {

  table = "trainer_social";

  edit(data,user_id){
    let iData = {
      user_id: user_id
    };
    ['facebook','instagram','linkedin','pinterest','twitter','youtube']
    .forEach(fld => iData[fld] = data[fld]);

    return this.deleteWhere({'user_id': user_id})
    .then(res => this.add(iData))
    .then(data => ({
      success: true,
      data: iData,
      message: 'Data saved!'
    }));
    
  }

}

module.exports = {TrainerAward, TrainerCalib, TrainerAcademic, TrainerExp, TrainerAbout, TrainerServices, TrainerKnowledge, TrainerCommunity, TrainerLibrary, TrainerCourse, TrainerCourseContent, TrainerCourseResource, TrainerSearch, TrainerBlog, TrainerRating, TrainerSocial};