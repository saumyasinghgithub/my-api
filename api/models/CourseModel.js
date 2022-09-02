const _ = require('lodash');
const BaseModel = require('./BaseModel');

class CourseModel extends BaseModel {

  table = "courses";
  getBySlug({slug,user_id}){
   let whereParams = {where: {slug: slug}, limit: 1}
    let cData = {};
    return this.list(whereParams)
    .then(({data}) => {
      cData.course=_.get(data,'0',{});
      if(_.get(cData,'course.id',false)){
        return this.getCourseResources(cData.course.id);
      }else{
        throw {message: "No such course found"};
      }
    })
    .then(({data}) => {
      cData.resources = data;
      return this.getCourseContents(cData.course.id);
    })
    .then(({data}) => {
      cData.contents = data;
      return this.db.run(`SELECT id FROM favorite_courses WHERE user_id=? AND course_id=?`,[user_id,cData.course.id])
    })
    .then((res) => {
      cData.isFav = _.get(res,'0.id', false) ? true : false;
      return cData;
    });
  }

  getCourseResources(course_id){
    return (new CourseResource()).list({'where' : {'course_id': course_id}, limit:9999999});
  }

  getCourseContents(course_id){
    return (new CourseContent()).list({'where' : {'course_id': course_id}, limit:9999999});
  }

  getByTrainer(tid){
    return this.list({where: {user_id:tid}, limit:9999999})
    .then(({data}) => {
      return this.getCoursesWithResources(data);
    })
  }

  getCoursesWithResources(courses){
    let idx = -1;
    return new Promise((resolve,reject) => {
      const getCourseWithResource = () => {
        if(++idx < courses.length){
          this.getCourseResources(courses[idx].id)
          .then(({data}) => courses[idx]['resources'] = data)
          .finally(getCourseWithResource)
        }else{
          resolve(courses);
        }
      };
      getCourseWithResource();
    });
  }

  markfav({user_id,course_id,fav}){
    return new Promise((resolve,reject) => {
      this.db.run(`DELETE FROM favorite_courses WHERE user_id=? AND course_id=?`,[user_id,course_id])
      .then(() => {
        if(parseInt(fav) === 1){
          return this.db.run(`INSERT INTO favorite_courses (user_id,course_id) VALUES (?,?)`,[user_id,course_id]);  
        }
      })
      .then(() => resolve({success:true}))
      .catch(reject);
    });
  }

  myFavs({user_id,start,limit}){
    return this.list({whereStr: `id IN (SELECT course_id FROM favorite_courses WHERE user_id=${user_id})`, start: start, limit: limit});
  }


}

class CourseResource extends BaseModel{
  table = "course_resources";
}

class CourseContent extends BaseModel{
  table = "course_content";
}

module.exports = CourseModel;