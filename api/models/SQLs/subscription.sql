CREATE TABLE `subscription` (`id` INT(11) NOT NULL AUTO_INCREMENT , `email` VARCHAR(300) NOT NULL , `trainerUrl` VARCHAR(300) NOT NULL , `created_at` TIMESTAMP NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;

ALTER TABLE `subscription` CHANGE `trainerUrl` `trainerUrl` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;
ALTER TABLE `subscription` CHANGE `created_at` `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;