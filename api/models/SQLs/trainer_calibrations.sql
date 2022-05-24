
CREATE TABLE `trainer_calibrations` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `pa_id` int(11) NOT NULL,
  `pa_value` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `trainer_calibrations` ADD PRIMARY KEY (`id`);
