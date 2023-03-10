CREATE TABLE `corporate_groups` (
    `id` INT(11) NOT NULL AUTO_INCREMENT ,
    `name` VARCHAR(255) NOT NULL ,
    `details` TEXT NULL ,
    `active` BOOLEAN NOT NULL ,
    `trainer_id` INT(11) NOT NULL ,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    `updated_at` DATETIME NULL ,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;


CREATE TABLE `corporate_groups_students` ( 
    `id` BIGINT(11) NOT NULL AUTO_INCREMENT , 
    `cg_id` INT(11) NOT NULL , 
    `student_id` INT(11) NOT NULL , 
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;


CREATE TABLE `import_students` ( 
    `id` INT(11) NOT NULL AUTO_INCREMENT , 
    `record` JSON NOT NULL , 
    `cg_id` INT(11) NOT NULL , 
    `imported_at` DATETIME NULL , 
    PRIMARY KEY (`id`)) ENGINE = InnoDB;


CREATE TABLE `corporate_groups_courses` ( 
    `id` INT(11) NOT NULL AUTO_INCREMENT , 
    `cg_id` INT(11) NOT NULL , 
    `course_id` INT(11) NOT NULL , 
    `moodle_id` INT(11) NULL DEFAULT NULL , 
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , 
    PRIMARY KEY (`id`)) ENGINE = InnoDB;