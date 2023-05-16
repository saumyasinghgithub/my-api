CREATE TABLE `settings` (`id` INT(11) NOT NULL AUTO_INCREMENT , `trainer_id` INT(11) NOT NULL DEFAULT '0' , `company_name` VARCHAR(100) NULL , `site_title` VARCHAR(100) NULL , `logo` VARCHAR(255) NULL , `contact_email` VARCHAR(255) NULL , `contact_address` VARCHAR(255) NULL , `contact_phone` VARCHAR(50) NULL , `copywrite_text` VARCHAR(200) NULL , `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , `updated_at` DATETIME NULL , PRIMARY KEY (`id`), UNIQUE (`trainer_id`)) ENGINE = InnoDB;

ALTER TABLE `settings` CHANGE `copywrite_text` `copyright_text` VARCHAR(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL;
ALTER TABLE `settings` ADD `favicon` VARCHAR(255) NULL AFTER `logo`;
ALTER TABLE `settings` CHANGE `site_title` `company_url` VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL;

