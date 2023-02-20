CREATE TABLE `course_resources` ( 
  `id` BIGINT(11) NOT NULL AUTO_INCREMENT , 
  `course_id` INT(11) NOT NULL , 
  `type` ENUM('pdf','scorm','audio','video') NULL , 
  `name` VARCHAR(100) NULL , 
  `price` DECIMAL(10,2) NULL , 
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , 
  PRIMARY KEY (`id`)) ENGINE = InnoDB;

  ALTER TABLE `course_resources` CHANGE `type` `type` ENUM('pdf','scorm','audio','video','PPT','webinar') CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL;