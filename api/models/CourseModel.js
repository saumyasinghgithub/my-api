const _ = require('lodash');
const BaseModel = require('./BaseModel');
const TModel = require('./TrainerModel');

class CourseModel extends BaseModel {

  table = "courses";
  getBySlug({slug}){
   let whereParams = {where: {slug: slug}, limit: 1}
    let cData = {};
    return (new TModel.TrainerCourse()).list(whereParams)
    .then(({data}) => {
      cData.course=_.get(data,'0',{});
      if(_.get(cData,'course.id',false)){
        whereParams = {'where' : {'course_id': cData.course.id}};
        return (new TModel.TrainerCourseResource()).list(whereParams);
      }else{
        throw {message: "No such course found"};
      }
    })
    .then(({data}) => {
      cData.resources = data;
      return (new TModel.TrainerCourseContent()).list(whereParams);
    })
    .then(({data}) => {
      cData.contents = data;
      return (new TModel.TrainerAbout()).list({'where' : {'user_id': cData.course.user_id}});
    })
    .then(({data}) => {
      cData.about = data;
      return cData;
    });
  }

  getByTrainer(tid){
    return this.list({where: {user_id:tid}, limit:9999999})
  }

}



module.exports = CourseModel;