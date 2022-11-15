CREATE TABLE `course_rating` ( `id` int(11) NOT NULL,
`user_id` int(11) NOT NULL,
`course_id` int(11) NOT NULL, 
`rating` int(2) NOT NULL, 
`timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ) 
ENGINE=InnoDB DEFAULT CHARSET=latin1