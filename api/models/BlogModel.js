const _ = require('lodash');
const BaseModel = require('./BaseModel');

class BlogModel extends BaseModel {

  table = "blogs";
  getBySlug({slug}){
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


}

class CourseResource extends BaseModel{
  table = "course_resources";
}

class CourseContent extends BaseModel{
  table = "course_content";
}

module.exports = BlogModel;