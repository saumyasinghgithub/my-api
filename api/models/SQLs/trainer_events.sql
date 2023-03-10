CREATE TABLE `ks_ad_crmdb`.`trainer_events` (`id` INT(11) NOT NULL AUTO_INCREMENT , `user_id` INT(11) NOT NULL , `event_short_desc` VARCHAR(300) NOT NULL , `registration_link` VARCHAR(300) NOT NULL , `created_at` DATETIME NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;

ALTER TABLE `trainer_events` ADD `event_img` VARCHAR(300) NOT NULL AFTER `user_id`;