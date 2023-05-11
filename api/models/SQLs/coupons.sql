CREATE TABLE `trainer_coupons` (
  `id` int(11) NOT NULL,
  `trainer_id` INT(11) NOT NULL,
  `coupon_code` varchar(200) NOT NULL,
  `usage_limit` int(11) NOT NULL DEFAULT 0,
  `course_ids` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NULL DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `coupon_type` int(11) NOT NULL,
  `discount_value` int(11) NOT NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `trainer_coupons` CHANGE `id` `id` INT(11) NOT NULL AUTO_INCREMENT, add PRIMARY KEY (`id`);


ALTER TABLE `trainer_coupons` ADD UNIQUE(`coupon_code`);
