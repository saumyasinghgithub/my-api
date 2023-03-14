CREATE TABLE `trainer_events` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `event_img` varchar(300) NOT NULL,
  `event_short_desc` varchar(300) NOT NULL,
  `registration_link` varchar(300) NOT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `trainer_events`
  ADD PRIMARY KEY (`id`);