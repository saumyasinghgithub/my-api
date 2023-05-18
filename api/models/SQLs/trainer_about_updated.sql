ALTER TABLE `trainer_about` ADD `company_url` VARCHAR(500) NOT NULL AFTER `company`;


ALTER TABLE `trainer_about`
  DROP `logo_image`,
  DROP `phone`,
  DROP `email`,
  DROP `company`;