
CREATE TABLE `trainer_slider` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `slider_image` varchar(300) NOT NULL,
  `slider_text` varchar(300) NOT NULL,
  `cta_link` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `trainer_slider`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `trainer_slider`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;