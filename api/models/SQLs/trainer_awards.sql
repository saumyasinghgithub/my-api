
CREATE TABLE `trainer_awards` (
  `id` bigint(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `award` varchar(255) NOT NULL,
  `organisation` varchar(255) NOT NULL,
  `year` int(4) NOT NULL,
  `url` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trainer_awards`
--

--
-- Indexes for table `trainer_awards`
--
ALTER TABLE `trainer_awards`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `trainer_awards`
--
ALTER TABLE `trainer_awards`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
