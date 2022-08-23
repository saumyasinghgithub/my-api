ALTER TABLE `users` ADD `moodle_id` INT(11) NULL AFTER `role_id`;
ALTER TABLE `courses` ADD `moodle_id` INT(11) NULL AFTER `id`;