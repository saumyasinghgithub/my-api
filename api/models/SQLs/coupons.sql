CREATE TABLE `trainer_coupons` (
  `id` int(11) NOT NULL,
  `trainer_id` int(11) NOT NULL,
  `coupon_code` varchar(200) NOT NULL,
  `usage_limit` int(11) DEFAULT NULL,
  `course_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `coupon_type` int(11) NOT NULL,
  `discount_value` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


ALTER TABLE `trainer_coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coupon_code` (`coupon_code`);
  
  
  ALTER TABLE `trainer_coupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
