-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 11, 2022 at 05:58 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.2.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
-- Table structure for table `profile_attributes`
--

CREATE TABLE `profile_attributes` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `title` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `profile_attributes`
--

INSERT INTO `profile_attributes` (`id`, `parent_id`, `title`, `active`, `created_at`, `updated_at`) VALUES
(1, 0, 'Industries', 1, '2022-05-11 20:35:03', NULL),
(2, 1, 'Agriculture', 1, '2022-05-11 20:36:29', NULL),
(3, 1, 'Information Technology', 1, '2022-05-11 20:36:29', NULL),
(4, 1, 'Mining, and Oil and Gas Extraction', 1, '2022-05-11 20:36:29', NULL),
(5, 1, 'Construction', 1, '2022-05-11 20:36:29', NULL),
(6, 1, 'Manufacturing', 1, '2022-05-11 20:36:29', NULL),
(7, 1, 'Wholesale Trade', 1, '2022-05-11 20:36:29', NULL),
(8, 1, 'Retail Trade', 1, '2022-05-11 20:36:29', NULL),
(9, 1, 'Transportation and Warehousing', 1, '2022-05-11 20:36:29', NULL),
(10, 1, 'Finance and Insurance', 1, '2022-05-11 20:36:29', NULL),
(11, 1, 'Professional, Scientific, and Technical Services', 1, '2022-05-11 20:36:29', NULL),
(12, 1, 'Educational Services', 1, '2022-05-11 20:36:29', NULL),
(13, 1, 'Health Care and Social Assistance', 1, '2022-05-11 20:36:29', NULL),
(14, 1, 'Arts, Entertainment, and Recreation', 1, '2022-05-11 20:36:29', NULL),
(15, 1, 'Accommodation and Food Services', 1, '2022-05-11 20:36:29', NULL),
(16, 1, 'Other Services (except Public Administration', 1, '2022-05-11 20:36:29', NULL),
(17, 1, 'Public Administration', 1, '2022-05-11 20:36:29', NULL),
(18, 0, 'Sub Industries', 1, '2022-05-11 20:37:12', NULL),
(19, 18, 'Fertilizers', 1, '2022-05-11 21:03:52', NULL),
(20, 18, 'Organic Methods', 1, '2022-05-11 21:03:52', NULL),
(21, 18, 'Telecommunications', 1, '2022-05-11 21:03:52', NULL),
(22, 18, 'Diamond Processing', 1, '2022-05-11 21:03:52', NULL),
(23, 18, 'Iron', 1, '2022-05-11 21:03:52', NULL),
(24, 18, 'Steel', 1, '2022-05-11 21:03:52', NULL),
(25, 0, 'Functional', 1, '2022-05-11 21:04:26', NULL),
(26, 25, 'Human Resource', 1, '2022-05-11 21:04:42', NULL),
(27, 25, 'Production', 1, '2022-05-11 21:04:42', NULL),
(28, 25, 'Operations', 1, '2022-05-11 21:04:42', NULL),
(29, 25, 'Wireless', 1, '2022-05-11 21:04:42', NULL),
(30, 25, 'Finance', 1, '2022-05-11 21:04:42', NULL),
(31, 25, 'Marketing', 1, '2022-05-11 21:04:42', NULL),
(32, 25, 'Administration', 1, '2022-05-11 21:04:42', NULL),
(33, 25, 'Customer Service Support', 1, '2022-05-11 21:04:42', NULL),
(34, 25, 'Sales', 1, '2022-05-11 21:04:42', NULL),
(35, 25, 'Distribution', 1, '2022-05-11 21:04:42', NULL),
(36, 25, 'Research', 1, '2022-05-11 21:04:42', NULL),
(37, 25, 'Information Technology', 1, '2022-05-11 21:04:42', NULL),
(38, 25, 'Legal', 1, '2022-05-11 21:04:42', NULL),
(39, 25, 'Purchase and Procurement', 1, '2022-05-11 21:04:42', NULL),
(40, 25, 'Design', 1, '2022-05-11 21:04:42', NULL),
(41, 25, 'Product Management', 1, '2022-05-11 21:04:42', NULL),
(42, 25, 'Leadership and Management', 1, '2022-05-11 21:04:42', NULL),
(43, 25, 'Corporate Communications', 1, '2022-05-11 21:04:42', NULL),
(44, 0, 'Sub Functional', 1, '2022-05-11 21:05:10', NULL),
(45, 44, 'Software', 1, '2022-05-11 21:05:29', NULL),
(46, 44, 'Networking and Security', 1, '2022-05-11 21:05:29', NULL),
(47, 44, 'Cloud Management', 1, '2022-05-11 21:05:29', NULL),
(48, 44, 'Operating Systems', 1, '2022-05-11 21:05:29', NULL),
(49, 44, 'System Support and Administration', 1, '2022-05-11 21:05:29', NULL),
(50, 44, 'ERP', 1, '2022-05-11 21:05:29', NULL),
(51, 0, 'Qualifications', 1, '2022-05-11 21:05:41', NULL),
(52, 51, 'Graduate Degree', 1, '2022-05-11 21:06:03', NULL),
(53, 51, 'Masters Degree', 1, '2022-05-11 21:06:03', NULL),
(54, 51, 'PHD / Doctorate', 1, '2022-05-11 21:06:03', NULL),
(55, 51, 'Professional Degree', 1, '2022-05-11 21:06:03', NULL),
(56, 0, 'University', 1, '2022-05-11 21:06:12', NULL),
(57, 56, 'Top 50', 1, '2022-05-11 21:06:33', NULL),
(58, 56, 'under 100', 1, '2022-05-11 21:06:33', NULL),
(59, 56, 'under 200', 1, '2022-05-11 21:06:33', NULL),
(60, 56, 'under 300', 1, '2022-05-11 21:06:33', NULL),
(61, 56, 'under 400', 1, '2022-05-11 21:06:33', NULL),
(62, 56, 'under 500', 1, '2022-05-11 21:06:33', NULL),
(63, 56, 'under 600', 1, '2022-05-11 21:06:33', NULL),
(64, 56, 'under 700', 1, '2022-05-11 21:06:33', NULL),
(65, 56, 'under 800', 1, '2022-05-11 21:06:33', NULL),
(66, 56, 'under 900', 1, '2022-05-11 21:06:33', NULL),
(67, 56, 'under 1000', 1, '2022-05-11 21:06:33', NULL),
(68, 0, 'Experience', 1, '2022-05-11 21:06:40', NULL),
(69, 68, '20 +', 1, '2022-05-11 21:07:04', NULL),
(70, 68, '15 to 20', 1, '2022-05-11 21:07:04', NULL),
(71, 68, '10 to 15', 1, '2022-05-11 21:07:04', NULL),
(72, 68, '5 to 10', 1, '2022-05-11 21:07:04', NULL),
(73, 68, '2 to 5', 1, '2022-05-11 21:07:04', NULL),
(74, 0, 'Language', 1, '2022-05-11 21:07:21', NULL),
(75, 74, 'Arabic', 1, '2022-05-11 21:07:42', NULL),
(76, 74, 'English', 1, '2022-05-11 21:07:42', NULL),
(77, 74, 'Spanish', 1, '2022-05-11 21:07:42', NULL),
(78, 74, 'Portuguese', 1, '2022-05-11 21:07:42', NULL),
(79, 74, 'French', 1, '2022-05-11 21:07:42', NULL),
(80, 74, 'Urdu', 1, '2022-05-11 21:07:42', NULL),
(81, 74, 'Mandarin Chinese', 1, '2022-05-11 21:07:42', NULL),
(82, 74, 'Hindi', 1, '2022-05-11 21:07:42', NULL),
(83, 0, 'country', 1, '2022-05-11 21:08:08', NULL),
(84, 83, 'India', 1, '2022-05-11 21:08:35', NULL),
(85, 83, 'USA', 1, '2022-05-11 21:08:35', NULL),
(86, 83, 'Canada', 1, '2022-05-11 21:08:35', NULL),
(87, 83, 'France', 1, '2022-05-11 21:08:35', NULL),
(88, 83, 'Germany', 1, '2022-05-11 21:08:35', NULL),
(89, 83, 'United Kingdom', 1, '2022-05-11 21:08:35', NULL),
(90, 83, 'UAE', 1, '2022-05-11 21:08:35', NULL),
(91, 0, 'Company', 1, '2022-05-11 21:11:21', NULL),
(92, 91, 'Fortune 50', 1, '2022-05-11 21:11:43', NULL),
(93, 91, 'Fortune 100', 1, '2022-05-11 21:11:43', NULL),
(94, 91, 'Fortune 200', 1, '2022-05-11 21:11:43', NULL),
(95, 91, 'Fortune 300', 1, '2022-05-11 21:11:43', NULL),
(96, 91, 'Fortune 400', 1, '2022-05-11 21:11:43', NULL),
(97, 91, 'Fortune 500', 1, '2022-05-11 21:11:43', NULL),
(98, 91, 'Fortune 1000', 1, '2022-05-11 21:11:43', NULL),
(99, 0, 'Certifications', 1, '2022-05-11 21:12:52', NULL),
(100, 99, 'COPC Inc', 1, '2022-05-11 21:13:28', NULL),
(101, 99, 'Avaya  Certification', 1, '2022-05-11 21:13:28', NULL),
(102, 99, 'ACIS &amp; ACSS', 1, '2022-05-11 21:13:28', NULL),
(103, 99, 'ACSS', 1, '2022-05-11 21:13:28', NULL),
(104, 99, 'AT&amp;T', 1, '2022-05-11 21:13:28', NULL),
(105, 99, 'Sumaria Networks LLC', 1, '2022-05-11 21:13:28', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `profile_attributes`
--
ALTER TABLE `profile_attributes`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `profile_attributes`
--
ALTER TABLE `profile_attributes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
