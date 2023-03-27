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
      return this.getCourseRatings(cData.course.id);
    })
    .then((rating) => {
      cData.rating = rating;
      return this.db.run(`SELECT id FROM favorite_courses WHERE user_id=? AND course_id=?`,[user_id,cData.course.id])
    })
    .then((res) => {
      cData.isFav = _.get(res,'0.id', false) ? true : false;
      return cData;
    });
  }

  getCourseRatings(course_id){
    let ratingObj = {rating:0, ratings: 0, enrollments: 0};
    return (new CourseRating()).getRatingByCourse(course_id)
    .then(rating => {
      ratingObj = {...ratingObj, ...rating};
      return this.recordCount('users','active=1');
    })   
    .then(total => {
      console.log(total);
      return {
        ...ratingObj,
        enrollments: total
      };
    }); 
  }

  fetchRatings(cids){
    return (new CourseRating()).getRatingByCourses(cids);
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
    }).then(courses =>{
      return this.fetchRatings(courses.map(c => c.id))
      .then(ratings => {
        return courses.map(course=>({...course,rating:ratings[course.id]}))
      })
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

  setRating(rating){
    return (new CourseRating()).save(rating)
    .then(() => this.getCourseRatings(rating.course_id))
    .then(ratingObj => ({success:true, rating: ratingObj}));
  }


}

class CourseResource extends BaseModel{
  table = "course_resources";
}

class CourseContent extends BaseModel{
  table = "course_content";
}

class CourseRating extends BaseModel{
  table = "course_rating";

  getRatingByCourses(cids){
    let ratings = {};
    cids.forEach(id => ratings[id]={rating:0, ratings: 0});
    if(cids.length === 0) cids[0] = -1 ;
    return new Promise((resolve,reject)=>{
      this.db.run('SELECT course_id,AVG(rating) as rating,COUNT(id) as ratings FROM  ' + this.table + ' WHERE course_id IN ('+cids.join(',')+') GROUP BY course_id')
      .then(res => {
        res.forEach(r => ratings[r.course_id] = {
          rating: _.isNull(r.rating) ? 0 : r.rating,
          ratings: _.get(r,'ratings',0)
        });
      })
      .catch(err => {/* do nothing */})
      .finally(() => resolve(ratings))
    });
  }

  getRatingByCourse(course_id){
    return this.db.run('SELECT AVG(rating) as rating,COUNT(user_id) as ratings FROM ' + this.table + ' WHERE course_id=?',[course_id])
      .then(res => ({
        rating: _.isNull(res[0].rating) ? 0 : res[0].rating,
        ratings: _.get(res,'0.ratings',0)
      }))
      .catch(err => ({rating:0, ratings: 0}));
  }

  save(ratingObj){
    return this.deleteWhere({user_id: ratingObj.user_id, course_id: ratingObj.course_id})
    .then(() => this.add(ratingObj));
  }
}

module.exports = CourseModel;