CREATE TABLE `trainer_exp` ( 
  `id` BIGINT(11) NOT NULL AUTO_INCREMENT , 
  `user_id` INT(11) NOT NULL , 
  `company` VARCHAR(255) NOT NULL , 
  `location` VARCHAR(255) NOT NULL , 
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , 
  PRIMARY KEY (`id`)) ENGINE = InnoDB;


  CREATE TABLE `trainer_about` ( 
    `id` BIGINT(11) NOT NULL AUTO_INCREMENT , 
    `user_id` INT NOT NULL , 
    `firstname` VARCHAR(255) NOT NULL , 
    `middlename` VARCHAR(255) NULL , 
    `lastname` VARCHAR(255) NOT NULL , 
    `biography` TEXT NULL ,
    `certificates` TEXT NULL , 
    `trainings` TEXT NULL , 
    `profile_image` VARCHAR(100) NULL , 
    `award_image` VARCHAR(100) NULL , 
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , 
    PRIMARY KEY (`id`)) ENGINE = InnoDB;