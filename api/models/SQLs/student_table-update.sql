ALTER TABLE `student_about` ADD `industry` VARCHAR(100) NOT NULL AFTER `lastname`,
ADD `qulification` VARCHAR(100) NOT NULL AFTER `industry`,
ADD `interested_field` VARCHAR(100) NOT NULL AFTER `qulification`,
ADD `country` VARCHAR(100) NOT NULL AFTER `interested_field`;


ALTER TABLE `student_about` ADD `linkedin` VARCHAR(100) NOT NULL AFTER `country`, 
ADD `facebook` VARCHAR(100) NOT NULL AFTER `linkedin`, 
ADD `youtube` VARCHAR(100) NOT NULL AFTER `facebook`, 
ADD `twitter` VARCHAR(100) NOT NULL AFTER `youtube`;