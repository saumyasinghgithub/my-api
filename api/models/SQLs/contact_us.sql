-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 31, 2022 at 06:10 AM
-- Server version: 10.1.29-MariaDB
-- PHP Version: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ks_ad_crmdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact_us`
--

CREATE TABLE `contact_us` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `submitted_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contact_us`
--

INSERT INTO `contact_us` (`id`, `name`, `phone`, `email`, `message`, `submitted_at`) VALUES
(2, 'Rajesh', '9871050857', 'rajeshs@knowledgesynonyms.net', 'This is test', '2022-08-30 16:39:52'),
(3, 'Rajesh', '9871050857', 'rajeshs@knowledgesynonyms.net', 'This is test', '2022-08-30 16:51:36'),
(4, 'Rajesh', '9871050857', 'rajeshs@knowledgesynonyms.net', 'This is test', '2022-08-30 16:51:55'),
(5, 'Rajesh', '9871050857', 'rajeshs@knowledgesynonyms.net', 'This is test', '2022-08-30 16:53:52'),
(6, 'Rajesh', '9871050857', 'rajeshs@knowledgesynonyms.net', 'This is test', '2022-08-30 17:14:51'),
(7, 'Rajesh', '9871050857', 'rajeshs@knowledgesynonyms.net', 'This is test', '2022-08-30 17:15:25'),
(8, 'Rajesh Singh', '9871050857', 'rajeshs@knowledgesynonyms.com', 'This is the test form', '2022-08-30 18:02:14'),
(9, 'Rajesh Singh', '9871050857', 'surojitb@knowledgesynonyms.com', 'This is the test form', '2022-08-30 18:05:34'),
(10, 'Rajesh Singh', '9871050857', 'rajeshs@knowledgesynonyms.com', 'This is the test form', '2022-08-30 18:06:16'),
(11, 'Rajesh Singh', '9871050857', 'rajeshs@knowledgesynonyms.com', 'This is the test form', '2022-08-30 18:07:50'),
(12, 'Rajesh Singh', '9871050857', 'rajeshs@knowledgesynonyms.com', 'This is the test form', '2022-08-30 18:09:11'),
(13, 'Rajesh Singh', '9871050857', 'rajeshs@knowledgesynonyms.com', 'This is the test form', '2022-08-30 18:09:15'),
(14, 'Rajesh Singh', '9871050857', 'rajeshs@knowledgesynonyms.net', 'tgfsdaadsfbgfdsadfsddf', '2022-08-30 18:09:59'),
(15, 'Rajesh Singh', '9871050857', 'rajeshs@knowledgesynonyms.net', 'tgfsdaadsfbgfdsadfsddf', '2022-08-30 18:11:47'),
(16, 'dasdsad', '765432165432', 'rajeshs@knowledgesynonyms.net', 'gfdsa', '2022-08-30 18:12:15'),
(17, 'dasdsad', '765432165432', 'rajeshs@knowledgesynonyms.net', 'gfdsa', '2022-08-30 18:12:42'),
(18, 'Rajesh Singh', '9871050857', 'rajeshs@knowledgesynonyms.com', 'sadfgh', '2022-08-30 18:39:23'),
(19, 'Rajesh Singh', '9871050857', 'rajeshs@knowledgesynonyms.com', 'sadfgh', '2022-08-30 18:40:34'),
(20, 'saadsfghj', '987654321', 'rajeshs@knowledgesynonyms.com', 'kujhgfdsa', '2022-08-30 18:40:58'),
(21, 'saadsfghj', '987654321', 'rajeshs@knowledgesynonyms.com', 'kujhgfdsa', '2022-08-30 18:43:06'),
(22, 'saadsfghj', '987654321', 'rajeshs@knowledgesynonyms.com', 'kujhgfdsa', '2022-08-30 18:43:10'),
(23, 'ASDFGHJ', '89765432', 'rajeshs@knowledgesynonyms.com', 'JKHGFDSA', '2022-08-30 18:43:33'),
(24, 'ASDFGHJ', '89765432', 'rajeshs@knowledgesynonyms.com', 'JKHGFDSA', '2022-08-30 18:44:51'),
(25, 'ASADFG', '87965432', 'rajeshs@knowledgesynonyms.com', 'HJGFDSA', '2022-08-30 18:45:30'),
(26, 'ASDFGHJ', '89765432', 'rajeshs@knowledgesynonyms.com', 'JKHGFDSA', '2022-08-30 18:46:47'),
(27, 'ASDFGHJ', '89765432', 'rajeshs@knowledgesynonyms.com', 'JKHGFDSA', '2022-08-30 18:46:49'),
(28, 'ASDFGHJ', '89765432', 'rajeshs@knowledgesynonyms.com', 'JKHGFDSA', '2022-08-30 18:47:09'),
(29, 'ASDFGHJ', '89765432', 'rajeshs@knowledgesynonyms.com', 'JKHGFDSA', '2022-08-30 18:47:36'),
(30, 'ASDFGHJ', '89765432', 'rajeshs@knowledgesynonyms.com', 'JKHGFDSA', '2022-08-30 18:52:05'),
(31, 'ASDFGHJ', '89765432', 'rajeshs@knowledgesynonyms.com', 'JKHGFDSA', '2022-08-30 18:52:12'),
(32, 'ASDFGHJ', '89765432', 'rajeshs@knowledgesynonyms.com', 'JKHGFDSA', '2022-08-30 18:53:05'),
(33, 'ASDFGHJ', '89765432', 'rajeshs@knowledgesynonyms.com', 'JKHGFDSA', '2022-08-30 18:53:09'),
(34, 'asdfsa', '897654324567', 'rajesh@gmail.com', 'aSDFGHJGFDSA', '2022-08-30 18:54:15'),
(35, 'ASDFGHJ', '89765432', 'rajeshs@knowledgesynonyms.com', 'JKHGFDSA', '2022-08-30 18:55:36'),
(36, 'ASDFGHJ', '89765432', 'rajeshs@knowledgesynonyms.com', 'JKHGFDSA', '2022-08-30 18:55:39'),
(37, 'ASDFGHJ', '89765432', 'rajeshs@knowledgesynonyms.com', 'JKHGFDSA', '2022-08-30 18:55:42'),
(38, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 18:57:11'),
(39, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 18:59:02'),
(40, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:01:00'),
(41, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:01:03'),
(42, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:01:45'),
(43, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:03:41'),
(44, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:03:44'),
(45, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:03:47'),
(46, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:06:30'),
(47, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:06:33'),
(48, 'sdsadas', '645645645', 'rajeshs@knowledgesynonyms.com', 'dsfdsdf', '2022-08-30 19:07:31'),
(49, 'sdsadas', '645645645', 'rajeshs@knowledgesynonyms.com', 'dsfdsdf', '2022-08-30 19:10:31'),
(50, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:10:34'),
(51, 'sdsadas', '645645645', 'rajeshs@knowledgesynonyms.com', 'dsfdsdf', '2022-08-30 19:18:31'),
(52, 'dasdas', '423423423', 'rajeshs@knowledgesynonyms.com', 'ddsfsdfsf', '2022-08-30 19:19:03'),
(53, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:21:40'),
(54, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:22:08'),
(55, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:22:46'),
(56, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:22:49'),
(57, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:26:09'),
(58, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:26:13'),
(59, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:33:27'),
(60, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:33:45'),
(61, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:34:28'),
(62, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:48:03'),
(63, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:48:13'),
(64, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:51:42'),
(65, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:51:45'),
(66, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:52:53'),
(67, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:52:53'),
(68, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:52:55'),
(69, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:52:58'),
(70, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:53:18'),
(71, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:53:23'),
(72, 'Rajesh Singh', '98765432', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 19:54:04'),
(73, 'Rajesh Singh', '98765432', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 19:54:45'),
(74, 'Rajesh Singh', '98765432', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 19:54:49'),
(75, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:55:17'),
(76, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:55:20'),
(77, 'asdfgdsadf', '8765435675', 'rajeshsingh@gmail.com', 'dasfgdsadf', '2022-08-30 19:55:37'),
(78, 'Rajesh Sisodia', '87654324567', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 19:56:13'),
(79, 'Rajesh Sisodia', '87654324567', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 19:57:41'),
(80, 'Rajesh Sisodia', '87654324567', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 19:57:44'),
(81, 'Rajesh Sisodia', '87654324567', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 19:58:30'),
(82, 'Rajesh Sisodia', '87654324567', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 19:59:22'),
(83, 'Rajesh Sisodia', '87654324567', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 19:59:25'),
(84, 'Rajesh Sisodia', '9999999999999999', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 19:59:49'),
(85, 'Rajesh Sisodia', '87654324567', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 20:00:23'),
(86, 'Rajesh Sisodia', '87654324567', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 20:00:25'),
(87, 'Rajesh Sisodia', '87654324567', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 20:00:28'),
(88, 'Rajesh Sisodiaa', '8888888888888888', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 20:01:10'),
(89, 'Rajesh Sisodia', '87654324567', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 20:01:53'),
(90, 'Rajesh Sisodia', '87654324567', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 20:01:57'),
(91, 'Rajesh Sisodia', '2222222222', 'rajeshs@knowledgesynonyms.com', 'sadadas', '2022-08-30 20:02:14'),
(92, 'Rajesh Sisodia', '87654324567', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 20:04:40'),
(93, 'Rajesh Sisodia', '87654324567', 'rajeshs@knowledgesynonyms.com', 'this is test', '2022-08-30 20:04:43'),
(94, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:05:14'),
(95, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:06:03'),
(96, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:06:07'),
(97, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:06:20'),
(98, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:06:23'),
(99, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:17:20'),
(100, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:20:42'),
(101, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:20:44'),
(102, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:20:45'),
(103, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:20:58'),
(104, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:21:01'),
(105, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:21:03'),
(106, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:21:05'),
(107, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:21:44'),
(108, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:21:47'),
(109, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:23:12'),
(110, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:23:14'),
(111, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:23:39'),
(112, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:25:20'),
(113, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:25:36'),
(114, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:25:38'),
(115, 'dasdasd', '65432', 'rajeshs@knowledgesynonyms.com', 'fsfsdfsf', '2022-08-30 20:25:42'),
(116, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:26:25'),
(117, 'dasdasd', '65432', 'rajeshs@knowledgesynonyms.com', 'fsfsdfsf', '2022-08-30 20:26:41'),
(118, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:27:05'),
(119, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:27:08'),
(120, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:29:42'),
(121, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:31:44'),
(122, 'dasdas', '423423432', 'rajeshs@knowledgesynonyms.com', 'dsadada', '2022-08-30 20:31:47'),
(123, 'Rajesh Singh', '9876543234', 'rajeshs@knowledgesynonyms.com', 'hgfdsa', '2022-08-31 08:49:14'),
(124, 'Rajesh Singh', '9876543234', 'rajeshs@knowledgesynonyms.com', 'hgfdsa', '2022-08-31 08:52:06'),
(125, 'Rajesh Singh', '9876543234', 'rajeshs@knowledgesynonyms.com', 'hgfdsa', '2022-08-31 08:59:30'),
(126, 'Rajesh Singh', '9876543234', 'rajeshs@knowledgesynonyms.com', 'hgfdsa', '2022-08-31 09:10:51'),
(127, 'Rajesh Singh', '9876543234', 'rajeshs@knowledgesynonyms.com', 'hgfdsa', '2022-08-31 09:25:01'),
(128, 'Rajesh Singh', '9876543234', 'rajeshs@knowledgesynonyms.com', 'hgfdsa', '2022-08-31 09:25:05'),
(129, 'Rajesh Singh', '9876543234', 'rajeshs@knowledgesynonyms.com', 'hgfdsa', '2022-08-31 09:25:10'),
(130, 'Rajesh Singh', '9876543234', 'rajeshs@knowledgesynonyms.com', 'hgfdsa', '2022-08-31 09:31:24'),
(131, 'Rajesh Singh', '9876543234', 'rajeshs@knowledgesynonyms.com', 'hgfdsa', '2022-08-31 09:31:27'),
(132, '', '', '', '', '2022-08-31 09:31:36'),
(133, 'Rajesh Singh', '9871050857', 'rajeshs@knowledgesynonyms.com', 'dfsdfsdf', '2022-08-31 09:32:00'),
(134, '', '', '', '', '2022-08-31 09:32:54'),
(135, 'Rajesh Singh', '9871050857', 'rajeshs@knowledgesynonyms.com', 'ddfsfsd', '2022-08-31 09:33:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact_us`
--
ALTER TABLE `contact_us`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact_us`
--
ALTER TABLE `contact_us`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
