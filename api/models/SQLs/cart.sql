CREATE TABLE `cart` ( 
  `id` INT(11) NOT NULL AUTO_INCREMENT , 
  `user_id` INT(11) NOT NULL , 
  `course_id` INT(11) NOT NULL , 
  `course_resources` JSON NULL , 
  `price` DECIMAL(10,2) NOT NULL , 
  `is_bundle` BOOLEAN NOT NULL DEFAULT FALSE , 
  `discount` DECIMAL(10,2) NOT NULL DEFAULT '0' , 
  `coupon_code` VARCHAR(50) NULL , 
  `status` ENUM('queue','processing','paid','cancelled') NOT NULL DEFAULT 'queue' , 
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , 
  `updated_at` DATETIME NOT NULL , 
  PRIMARY KEY (`id`)) ENGINE = InnoDB;