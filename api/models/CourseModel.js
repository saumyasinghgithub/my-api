const _ = require('lodash');
const BaseModel = require('./BaseModel');
const TModel = require('./TrainerModel');
const fs = require('fs');
const path = require('path');
const e = require('cors');

class CourseModel extends BaseModel {

  table = "courses";
  getBySlug({slug}){
   let whereParams = {where: {slug: slug}, limit: 1}
    let cData = {};
    return (new TModel.TrainerCourse()).list(whereParams)
    .then(({data}) => {
      //console.log(data)
      cData.course=_.get(data,'0',{});
        console.log("custom data", cData.course)
      if(_.get(cData,'course.id',false)){
        console.log(cData.course.id)
        whereParams = {'where' : {'course_id': cData.course.id}};
        console.log(whereParams)
        return (new TModel.TrainerCourseResource()).list(whereParams);
      }else{
        console.log(data.course.id)
        throw {message: "No such course found"};
      }
    })
    .then(({data}) => {
      cData.resouce = data;
      return (new TModel.TrainerCourseContent()).list(whereParams);
    })
    .then(({data}) => {
      cData.coursecontent = data;
      return cData;
    });
  }

}


module.exports = CourseModel;