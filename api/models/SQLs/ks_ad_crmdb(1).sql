-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 08, 2022 at 02:26 PM
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
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(150) NOT NULL,
  `rbac` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `role` enum('superadmin','admin') NOT NULL DEFAULT 'admin',
  `active` int(11) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`, `email`, `rbac`, `role`, `active`, `created_at`, `updated_at`) VALUES
(1, 'admin', '$2a$08$ZQCp7JGs0Z/w2GKluFA1OOQrmbKkYmkgEJ6mhVr1sd1WzPm5VBePC', 'surojit19@gmail.com', '{}', 'superadmin', 1, '2022-05-10 10:42:44', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sku` varchar(200) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `short_description` text,
  `description` text,
  `learn_brief` text,
  `requirements` text,
  `stock_qnty` int(11) DEFAULT NULL,
  `course_image` varchar(200) DEFAULT NULL,
  `level` varchar(100) DEFAULT NULL,
  `language` varchar(100) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `lectures` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `courses`
--

-- --------------------------------------------------------

--
-- Table structure for table `course_content`
--

CREATE TABLE `course_content` (
  `id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `video` varchar(255) DEFAULT NULL,
  `embed_resource` varchar(255) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `lecture` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `course_content`
--

INSERT INTO `course_content` (`id`, `course_id`, `title`, `description`, `video`, `embed_resource`, `duration`, `lecture`, `created_at`) VALUES
(1, 1, 'Automobile Engineering Courses', '<h3>Course Prerequisite</h3>\r\n<p>You will learn how to use Excel/Google Sheets to calculate the Net Present Value of capital projects. I am a Chartered Financial Analyst and I have included course material fro<span class=\"SecSec\">m the CFA Level 1 Exam to help you understand what the test would be like.</span></p>\r\n<div class=\"courseDesBox slideInUp wow\">\r\n<h3>Description</h3>\r\n<p class=\"addReadMore showlesscontent\">Do you want to understand the basic finance terms like Compounding Interest, Time Value of Money, Net Present Value and Modern Portfolio Theory?</p>\r\n</div>\r\n<div class=\"courseDesBox slideInUp wow\">\r\n<h3>About Instuctor</h3>\r\n<p class=\"addReadMore showlesscontent\">Ben started nos estorerepe nossita tionseq uaepere rumquia spient dolorro mi, cum eatis desto eraeptatis eatis ape litios accaest odigenis pa de laccuptat.</p>\r\n</div>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', 'content_undefined_SampleVideo_1280x720_20mb.mp4', '', 2, 5, '2022-07-01 11:10:57'),
(2, 1, 'Automobile Engineering Courses', '<p>Collaborating on Video<span class=\"SecSec\"> Lectures aim to help millions of students across the world acquire knowledge</span></p>', 'content_undefined_Context-doubt-session.mp4', '', 22, 11, '2022-07-01 11:16:59'),
(3, 1, 'Automobile Engineering Courses', '<p>Lectures aim to <span class=\"SecSec\"> help millions of students across the world acquire knowledge</span></p>', 'content_undefined_big_buck_bunny_720p_1mb.mp4', '', 5, 6, '2022-07-01 11:18:06'),
(4, 2, 'Corporate finance', '<h3>Course Prerequisite</h3>\r\n<p>You will learn how to use Excel/Google Sheets to calculate the Net Present Value of capital projects. I am a Chartered Financial Analyst and I have included course material fro<span class=\"SecSec\">m the CFA Level 1 Exam to help you understand what the test would be like. </span></p>\r\n<div class=\"courseDesBox slideInUp wow\">\r\n<h3>Description</h3>\r\n<p class=\"addReadMore showlesscontent\">Do you want to understand the basic finance terms like Compounding Interest, Time Value of Money, Net Present Value and Modern Portfolio Theory?</p>\r\n</div>\r\n<div class=\"courseDesBox slideInUp wow\">\r\n<h3>About Instuctor</h3>\r\n<p class=\"addReadMore showlesscontent\">Ben started nos estorerepe nossita tionseq uaepere rumquia spient dolorro mi, cum eatis desto eraeptatis eatis ape litios accaest odigenis pa de laccuptat.</p>\r\n</div>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>', 'content_undefined_Context-doubt-session.mp4', '', 5, 3, '2022-07-01 14:49:09'),
(5, 2, 'Corporate finance', '<p>Collaborating on Video<span class=\"SecSec\"> Lectures aim to help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_20mb.mp4', '', 3, 2, '2022-07-01 14:49:56'),
(6, 3, 'Data Science', '<p>You will learn how to use Excel/Google Sheets to calculate the Net Present Value of capital projects. I am a Chartered Financial Analyst and I have included course material fro<span class=\"SecSec\">m the CFA Level 1 Exam to help you understand what the test would be like.</span></p>\r\n<div class=\"courseDesBox slideInUp wow\">\r\n<h3>Description</h3>\r\n<p class=\"addReadMore showlesscontent\">Do you want to understand the basic finance terms like Compounding Interest, Time Value of Money, Net Present Value and Modern Portfolio Theory?</p>\r\n</div>\r\n<div class=\"courseDesBox slideInUp wow\">\r\n<h3>About Instuctor</h3>\r\n<p class=\"addReadMore showlesscontent\">Ben started nos estorerepe nossita tionseq uaepere rumquia spient dolorro mi, cum eatis desto eraeptatis eatis ape litios accaest odigenis pa de laccuptat.</p>\r\n</div>\r\n<p>&nbsp;</p>', 'content_undefined_Context-doubt-session.mp4', '', 85, 210, '2022-07-01 15:01:08'),
(7, 3, 'Data Science', '<p>Collaborating on Video<span class=\"SecSec\"> Lectures aim to help millions of students across the world acquire knowledge</span></p>', 'content_undefined_big_buck_bunny_720p_1mb.mp4', '', 22, 8, '2022-07-01 15:01:46'),
(8, 3, 'Data Science', '<p>Lectures aim to <span class=\"SecSec\"> help millions of students across the world acquire knowledge</span></p>', 'content_undefined_Context-doubt-session.mp4', '', 45, 23, '2022-07-01 15:02:46');

-- --------------------------------------------------------

--
-- Table structure for table `course_resources`
--

CREATE TABLE `course_resources` (
  `id` bigint(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `type` enum('pdf','scorm','audio','video','PPT') DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `course_resources`
--

INSERT INTO `course_resources` (`id`, `course_id`, `type`, `name`, `price`, `created_at`) VALUES
(1, 1, 'video', 'Automobile Engineering Courses', '80.00', '2022-07-01 10:51:51'),
(2, 1, 'scorm', 'Automobile Engineering Courses', '100.00', '2022-07-01 10:52:30'),
(5, 1, 'PPT', 'Automobile Engineering Courses', '95.00', '2022-07-01 11:00:48'),
(6, 2, 'audio', 'Corporate Finance', '80.00', '2022-07-01 14:50:27'),
(7, 2, 'PPT', 'Corporate Finance', '120.00', '2022-07-01 14:51:24'),
(8, 2, 'scorm', 'Corporate Finance', '150.00', '2022-07-01 14:51:47'),
(9, 3, 'audio', 'Data Science', '140.00', '2022-07-01 14:58:42'),
(10, 3, 'video', 'Data Science', '240.00', '2022-07-01 14:59:01'),
(11, 3, 'PPT', 'Data Science', '105.00', '2022-07-01 14:59:20');

-- --------------------------------------------------------

--
-- Table structure for table `profile_attributes`
--

CREATE TABLE `profile_attributes` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `title` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `profile_attributes`
--

INSERT INTO `profile_attributes` (`id`, `parent_id`, `title`, `active`, `created_at`, `updated_at`) VALUES
(1, 0, 'IndustriesTest', 1, '2022-05-11 20:35:03', NULL),
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

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL,
  `title` varchar(75) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `rbac` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `title`, `active`, `created_at`, `updated_at`, `rbac`) VALUES
(2, 'admin', 1, '2022-05-15 17:27:18', NULL, NULL),
(3, 'student', 0, '2022-05-15 17:32:23', NULL, NULL),
(4, 'trainer', 0, '2022-05-15 17:32:38', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `trainer_about`
--

CREATE TABLE `trainer_about` (
  `id` bigint(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `middlename` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) NOT NULL,
  `biography` text,
  `certificates` text,
  `trainings` text,
  `profile_image` varchar(100) DEFAULT NULL,
  `award_image` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trainer_about`
--

INSERT INTO `trainer_about` (`id`, `user_id`, `firstname`, `middlename`, `lastname`, `biography`, `certificates`, `trainings`, `profile_image`, `award_image`, `created_at`) VALUES
(1, 1, 'Rajesh', '', 'Singh', '<h3>Biography</h3>\r\n<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. </p>', NULL, '<div class=\"awadText slideInUp wow \">\r\n<p class=\"boldText\">Training Name Duration Start -/ End date Location</p>\r\n<p>Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \">\r\n<p class=\"boldText\">Training Name Duration Start -/ End date Location</p>\r\n<p>Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \">\r\n<p class=\"boldText\">Training Name Duration Start -/ End date Location</p>\r\n<p>Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \">\r\n<p class=\"boldText\">Training Name Duration Start -/ End date Location</p>\r\n<p>Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<p>&nbsp;</p>', 'profile__trainer2_1.jpg', 'award__service-img.jpg', '2022-07-08 09:34:29');

-- --------------------------------------------------------

--
-- Table structure for table `trainer_academic`
--

CREATE TABLE `trainer_academic` (
  `id` bigint(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `qualification` varchar(255) NOT NULL,
  `year` int(4) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trainer_academic`
--

INSERT INTO `trainer_academic` (`id`, `user_id`, `qualification`, `year`, `created_at`) VALUES
(1, 1, '10th Grade', 1975, '2022-05-29 14:19:32'),
(2, 1, '12th Grade', 1989, '2022-05-29 14:19:33'),
(3, 1, 'Graduation', 1987, '2022-05-29 14:19:33');

-- --------------------------------------------------------

--
-- Table structure for table `trainer_calibrations`
--

CREATE TABLE `trainer_calibrations` (
  `id` bigint(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `pa_id` int(11) NOT NULL,
  `pa_value` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `trainer_calibrations`
--

INSERT INTO `trainer_calibrations` (`id`, `user_id`, `pa_id`, `pa_value`, `created_at`) VALUES
(50, 1, 1, 2, '2022-07-08 10:10:19'),
(51, 1, 1, 3, '2022-07-08 10:10:19'),
(52, 1, 1, 4, '2022-07-08 10:10:19'),
(53, 1, 1, 5, '2022-07-08 10:10:19'),
(54, 1, 1, 6, '2022-07-08 10:10:19'),
(55, 1, 1, 7, '2022-07-08 10:10:19'),
(56, 1, 1, 8, '2022-07-08 10:10:20'),
(57, 1, 1, 11, '2022-07-08 10:10:20'),
(58, 1, 1, 12, '2022-07-08 10:10:20'),
(59, 1, 1, 14, '2022-07-08 10:10:20'),
(60, 1, 18, 19, '2022-07-08 10:10:20'),
(61, 1, 18, 20, '2022-07-08 10:10:20'),
(62, 1, 18, 21, '2022-07-08 10:10:20'),
(63, 1, 25, 26, '2022-07-08 10:10:20'),
(64, 1, 25, 27, '2022-07-08 10:10:20'),
(65, 1, 25, 28, '2022-07-08 10:10:20'),
(66, 1, 25, 29, '2022-07-08 10:10:20'),
(67, 1, 44, 45, '2022-07-08 10:10:20'),
(68, 1, 44, 46, '2022-07-08 10:10:20'),
(69, 1, 44, 47, '2022-07-08 10:10:20'),
(70, 1, 44, 48, '2022-07-08 10:10:20'),
(71, 1, 44, 49, '2022-07-08 10:10:20'),
(72, 1, 44, 50, '2022-07-08 10:10:20'),
(73, 1, 51, 52, '2022-07-08 10:10:20'),
(74, 1, 51, 53, '2022-07-08 10:10:20'),
(75, 1, 51, 54, '2022-07-08 10:10:20'),
(76, 1, 51, 55, '2022-07-08 10:10:20'),
(77, 1, 56, 57, '2022-07-08 10:10:20'),
(78, 1, 56, 58, '2022-07-08 10:10:20'),
(79, 1, 68, 69, '2022-07-08 10:10:20'),
(80, 1, 68, 70, '2022-07-08 10:10:21'),
(81, 1, 74, 76, '2022-07-08 10:10:21'),
(82, 1, 83, 84, '2022-07-08 10:10:21'),
(83, 1, 83, 85, '2022-07-08 10:10:21'),
(84, 1, 91, 92, '2022-07-08 10:10:21'),
(85, 1, 91, 93, '2022-07-08 10:10:21'),
(86, 1, 99, 100, '2022-07-08 10:10:21'),
(87, 1, 99, 101, '2022-07-08 10:10:21'),
(88, 1, 99, 102, '2022-07-08 10:10:21');

-- --------------------------------------------------------

--
-- Table structure for table `trainer_exp`
--

CREATE TABLE `trainer_exp` (
  `id` bigint(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `trainer_services`
--

CREATE TABLE `trainer_services` (
  `id` bigint(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `service_offer` text,
  `consultancy` text,
  `coaching` text,
  `service_image` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trainer_services`
--

INSERT INTO `trainer_services` (`id`, `user_id`, `service_offer`, `consultancy`, `coaching`, `service_image`, `created_at`) VALUES
(0, 1, NULL, NULL, NULL, '', '2022-06-01 12:30:20');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `role_id` int(11) NOT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `address` text,
  `zipcode` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `registered_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastlogin` datetime DEFAULT NULL,
  `intro` tinytext,
  `profile` text,
  `updated_at` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `firstname`, `middlename`, `lastname`, `country`, `address`, `zipcode`, `state`, `mobile`, `email`, `password`, `registered_at`, `lastlogin`, `intro`, `profile`, `updated_at`, `active`) VALUES
(1, 4, 'Rajesh', 'Kumar', 'Rajesh', 'India', 'Noida', '201001', 'UP', '9871050857', 'rajeshs@knowledgesynonyms.net', '$2a$08$o2ehfV2AnmggjV/VDhEzkOQ3AREMXYIdpNXrxj9EnemQ0ViPLTGZa', '2022-05-24 18:52:42', NULL, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users_roles`
--

CREATE TABLE `users_roles` (
  `user_id` bigint(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`);

--
-- Indexes for table `course_content`
--
ALTER TABLE `course_content`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `course_resources`
--
ALTER TABLE `course_resources`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `profile_attributes`
--
ALTER TABLE `profile_attributes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trainer_about`
--
ALTER TABLE `trainer_about`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trainer_academic`
--
ALTER TABLE `trainer_academic`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trainer_calibrations`
--
ALTER TABLE `trainer_calibrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trainer_exp`
--
ALTER TABLE `trainer_exp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trainer_services`
--
ALTER TABLE `trainer_services`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_mobile` (`mobile`),
  ADD UNIQUE KEY `uq_email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `course_content`
--
ALTER TABLE `course_content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `course_resources`
--
ALTER TABLE `course_resources`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `profile_attributes`
--
ALTER TABLE `profile_attributes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `trainer_about`
--
ALTER TABLE `trainer_about`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `trainer_academic`
--
ALTER TABLE `trainer_academic`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `trainer_calibrations`
--
ALTER TABLE `trainer_calibrations`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `trainer_exp`
--
ALTER TABLE `trainer_exp`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
