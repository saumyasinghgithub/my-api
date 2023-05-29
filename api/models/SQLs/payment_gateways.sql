CREATE TABLE `payment_gateways` ( 
    `id` INT(11) NOT NULL AUTO_INCREMENT , 
    `title` VARCHAR(255) NOT NULL , 
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE , 
    `logo` VARCHAR(255) NULL , 
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , 
    `updated_at` DATETIME NULL DEFAULT NULL , 
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;