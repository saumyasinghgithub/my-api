CREATE TABLE `favorite_courses` ( 
  `id` INT(11) NOT NULL AUTO_INCREMENT , 
  `user_id` INT(11) NOT NULL , 
  `course_id` INT(11) NOT NULL , 
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , 
  PRIMARY KEY (`id`)) ENGINE = InnoDB;