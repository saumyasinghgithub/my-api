CREATE TABLE `trainer_academic` ( 
  `id` BIGINT(11) NOT NULL AUTO_INCREMENT , 
  `user_id` INT(11) NOT NULL , 
  `qualification` VARCHAR(255) NOT NULL , 
  `year` INT(4) NOT NULL , 
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , 
  PRIMARY KEY (`id`)) 
  ENGINE = InnoDB;