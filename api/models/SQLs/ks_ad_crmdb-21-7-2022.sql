-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 21, 2022 at 03:24 PM
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
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
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
(8, 3, 'Data Science', '<p>Lectures aim to <span class=\"SecSec\"> help millions of students across the world acquire knowledge</span></p>', 'content_undefined_Context-doubt-session.mp4', '', 45, 23, '2022-07-01 15:02:46'),
(9, 4, 'ERP Bundle Course', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">You will learn how to use Excel/Google Sheets to calculate the Net Present Value of capital projects. I am a Chartered Financial Analyst and I have included course material fro</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">m the CFA Level 1 Exam to help you understand what the test would be like.</span></p>', 'content_undefined_Single-Video-Q2-Empathy-Opt_2.mp4', '', 5, 3, '2022-07-13 18:04:49'),
(10, 4, 'ERP Bundle Course', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">Collaborating on Video</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">&nbsp;Lectures aim to help millions of students across the world acquire knowledge</span></p>', 'content_undefined_big_buck_bunny_720p_1mb.mp4', '', 4, 4, '2022-07-13 18:07:04'),
(11, 8, 'Automobile Industries Courses', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Diploma in Automobile Engineering or Polytechnic in Automobile Engineering is a three years course, which is designed to help students gain basic knowledge and skills required by a professional working in the automobile industry.It is a basic course that a student can choose after completing Class 10th study and further go for higher education. During the course</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 10, 8, '2022-07-20 11:30:52'),
(12, 8, 'Automobile Industries Courses', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Lectures aim to&nbsp;</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 5, 7, '2022-07-20 11:32:15'),
(13, 9, 'Account and Financing', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Collaborating on Video</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;Lectures aim to help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 2, 4, '2022-07-20 12:14:44'),
(14, 9, 'Account and Financing', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Lectures aim to&nbsp;</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 12, 18, '2022-07-20 12:15:20'),
(15, 10, 'Data Science', '<table style=\"width: 1104px; border-spacing: 0px; max-width: 100%; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<tbody style=\"box-sizing: border-box;\">\r\n<tr style=\"box-sizing: border-box;\">\r\n<td style=\"box-sizing: border-box; vertical-align: top; padding: 0.75rem 0.75rem 15px; border: 0px; white-space: unset;\" colspan=\"2\" width=\"50%\">\r\n<p class=\"addReadMore showmorecontent\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px;\">Collaborating on Video<span class=\"SecSec\" style=\"box-sizing: border-box;\">&nbsp;Lectures aim to help millions of students across the world acquire knowledge</span></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 9, 15, '2022-07-20 12:34:20'),
(16, 10, 'Data Science', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Lectures aim to&nbsp;</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 5, 6, '2022-07-20 12:37:18'),
(17, 10, 'Data Science', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Collaborating on Video</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;Lectures aim to help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 1, 1, '2022-07-20 12:45:12'),
(18, 11, 'ERP Bundle Course', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Collaborating on Video</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;Lectures aim to help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 10, 14, '2022-07-20 13:15:24'),
(19, 11, 'ERP Bundle Course', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Lectures aim to&nbsp;</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 8, 8, '2022-07-20 13:16:56'),
(20, 12, 'Moodle Learning', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Collaborating on Video</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;Lectures aim to help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 4, 15, '2022-07-20 13:48:29'),
(21, 12, 'Moodle Learning', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Collaborating on Video</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;Lectures aims to help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 8, 7, '2022-07-20 13:49:19'),
(22, 13, 'TI Tutorial', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Collaborating on Video</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;Lectures aim to help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 10, 19, '2022-07-20 15:03:40'),
(23, 13, 'TI Tutorial', '<table style=\"width: 1104px; border-spacing: 0px; max-width: 100%; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<tbody style=\"box-sizing: border-box;\">\r\n<tr style=\"box-sizing: border-box;\">\r\n<td style=\"box-sizing: border-box; vertical-align: top; padding: 0.75rem 0.75rem 15px; border: 0px; white-space: unset;\" colspan=\"2\" width=\"50%\">\r\n<p class=\"addReadMore showmorecontent\" style=\"box-sizing: border-box; margin-top: 0px; margin-bottom: 10px;\">Lectures aim to&nbsp;<span class=\"SecSec\" style=\"box-sizing: border-box;\">help millions of students across the world acquire knowledge</span></p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 8, 3, '2022-07-20 15:04:17'),
(24, 14, 'Digital Manufacturing & Design Technology Specialization', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Collaborating on Video</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;Lectures aim to help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 10, 14, '2022-07-20 15:27:26'),
(25, 14, 'Digital Manufacturing & Design Technology Specialization', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Collaborating on Video</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;Lectures aim to help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 8, 4, '2022-07-20 15:28:22'),
(26, 15, 'Digital Marketing', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Collaborating on Video</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;Lectures aim to help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 8, 7, '2022-07-20 15:52:09'),
(27, 15, 'Digital Marketing', '', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 10, 15, '2022-07-20 15:52:54'),
(28, 15, 'Digital Marketing', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Lectures aim to&nbsp;</span><span class=\"SecSec\" style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">help millions of students across the world acquire knowledge</span></p>', 'content_undefined_SampleVideo_1280x720_1mb.mp4', '', 6, 3, '2022-07-20 15:54:11');

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
(11, 3, 'PPT', 'Data Science', '105.00', '2022-07-01 14:59:20'),
(12, 4, 'pdf', 'ERP Bundle Course', '150.00', '2022-07-13 17:07:08'),
(13, 4, 'scorm', 'ERP Bundle Course', '500.00', '2022-07-13 17:07:22'),
(14, 4, 'video', 'ERP Bundle Course', '230.00', '2022-07-13 17:07:37'),
(15, 4, 'PPT', 'ERP Bundle Course', '340.00', '2022-07-13 17:07:55'),
(16, 8, 'pdf', 'Automobile Industries Courses', '5.00', '2022-07-20 11:27:51'),
(17, 8, 'video', 'Automobile Industries Courses', '10.00', '2022-07-20 11:28:00'),
(18, 8, 'scorm', 'Automobile Industries Courses', '40.00', '2022-07-20 11:28:08'),
(19, 8, 'audio', 'Automobile Industries Courses', '15.00', '2022-07-20 11:28:19'),
(20, 8, 'PPT', 'Automobile Industries Courses', '20.00', '2022-07-20 11:28:45'),
(21, 9, 'scorm', 'Account and Financing', '210.00', '2022-07-20 12:13:00'),
(22, 9, 'video', 'Account and Financing', '200.00', '2022-07-20 12:13:10'),
(23, 9, 'pdf', 'Account and Financing', '185.00', '2022-07-20 12:13:18'),
(24, 9, 'audio', 'Account and Financing', '175.00', '2022-07-20 12:13:33'),
(25, 10, 'scorm', 'Data Science', '450.00', '2022-07-20 12:31:53'),
(26, 10, 'video', 'Data Science', '150.00', '2022-07-20 12:32:03'),
(27, 10, 'pdf', 'Data Science', '160.00', '2022-07-20 12:32:13'),
(28, 11, 'pdf', 'ERP Bundle Course', '90.00', '2022-07-20 13:03:18'),
(29, 11, 'video', 'ERP Bundle Course', '500.00', '2022-07-20 13:03:29'),
(30, 11, 'audio', 'ERP Bundle Course', '130.00', '2022-07-20 13:03:40'),
(31, 12, 'scorm', 'Moodle Learning', '99.00', '2022-07-20 13:47:20'),
(32, 12, 'pdf', 'Moodle Learning', '80.00', '2022-07-20 13:47:33'),
(33, 12, 'video', 'Moodle Learning', '80.00', '2022-07-20 13:47:41'),
(34, 12, 'PPT', 'Moodle Learning', '100.00', '2022-07-20 13:47:51'),
(35, 13, 'scorm', 'TI Tutorial', '75.00', '2022-07-20 15:02:47'),
(36, 13, 'audio', 'TI Tutorial', '15.00', '2022-07-20 15:02:56'),
(37, 13, 'video', 'TI Tutorial', '10.00', '2022-07-20 15:03:07'),
(38, 14, 'audio', 'Digital Manufacturing & Design Technology Specialization', '450.00', '2022-07-20 15:26:24'),
(39, 14, 'video', 'Digital Manufacturing & Design Technology Specialization', '180.00', '2022-07-20 15:26:32'),
(40, 14, 'pdf', 'Digital Manufacturing & Design Technology Specialization', '120.00', '2022-07-20 15:26:42'),
(41, 15, 'pdf', 'Digital Marketing', '250.00', '2022-07-20 15:50:34'),
(42, 15, 'scorm', 'Digital Marketing', '350.00', '2022-07-20 15:50:49'),
(43, 15, 'audio', 'Digital Marketing', '150.00', '2022-07-20 15:51:01'),
(44, 15, 'PPT', 'Digital Marketing', '10.00', '2022-07-20 15:51:22');

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
  `base_image` varchar(1200) DEFAULT NULL,
  `trainings` text,
  `profile_image` varchar(100) DEFAULT NULL,
  `award_image` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trainer_about`
--

INSERT INTO `trainer_about` (`id`, `user_id`, `firstname`, `middlename`, `lastname`, `biography`, `base_image`, `trainings`, `profile_image`, `award_image`, `created_at`) VALUES
(1, 1, 'Rajesh', '', 'Singh', '<h3>Biography</h3>\r\n<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. </p>', 'base_1_base-rajesh.png', '<div class=\"awadText slideInUp wow \">\r\n<p class=\"boldText\">Training Name Duration Start -/ End date Location</p>\r\n<p>Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \">\r\n<p class=\"boldText\">Training Name Duration Start -/ End date Location</p>\r\n<p>Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \">\r\n<p class=\"boldText\">Training Name Duration Start -/ End date Location</p>\r\n<p>Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \">\r\n<p class=\"boldText\">Training Name Duration Start -/ End date Location</p>\r\n<p>Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<p>&nbsp;</p>', 'profile_1_Bauman (1).jpg', 'award_1_bannerProfile.jpg', '2022-07-08 09:34:29'),
(2, 2, 'NOORHIMLI (HIMLI) ', '', 'ALI', '<p>With 20+ years of leadership experience in global training delivery, training management, regional sales and services management in the telecommunication, contact centre and consultancy industries, Himli offers proven track record and expertise in the Asia Pacific region. His career has spanned across several successful US multinational companies including IBM Germany, AT&amp;T, Lucent Technologies, Avaya Inc, Aspect Software Inc, COPC Inc, Sumaria Networks LLC (US), Minaya Learning LLC (US), The Training Associates Corp (US), Imparta (UK), PD Training (Australia) and technology/ training start-up companies in Singapore. He has held several senior sales and management positions in the region including being a co-founder of a technology startup company.</p>', 'base_2_noor.png', '<p><strong>Training that Himli had delivered:</strong></p>\r\n<ol>\r\n<li>John C. Maxwell Leadership Training</li>\r\n<ol>\r\n<li>The 21 Irrefutable Laws of Leadership</li>\r\n</ol>\r\n</ol>\r\n<ol>\r\n<li>Leadership &amp; You</li>\r\n<li>Leadership &amp; Them</li>\r\n</ol>\r\n<ul>\r\n<li>Leadership &amp; Environment</li>\r\n</ul>\r\n<ol>\r\n<ol>\r\n<li>Leadership Gold</li>\r\n<li>15 Invaluable Laws of Growth</li>\r\n<li>Everyone Communicates, Few Connect</li>\r\n</ol>\r\n<li>TetraMap Behaviour Profiling Training &ndash; Earth/Air/Water/Fire</li>\r\n<li>Channel Management Training</li>\r\n<li>Presentation Skills Training &ndash; Virtual and Face-to-Face</li>\r\n<li><strong>HP Contractual Selling Training</strong></li>\r\n<li>Motivational Training</li>\r\n<li>Motivational Coaching &amp; Mentoring Programs</li>\r\n<li>Doon Innovation Methodologies</li>\r\n<li><strong>Value Selling and Creating Client Value Programs</strong></li>\r\n<li><strong>Coaching for Impact Sales Manager Programs</strong></li>\r\n<li>Leadership, Management &amp; Employee related Microsoft Global Programs</li>\r\n</ol>\r\n<p>&nbsp;</p>', 'profile_2_bg_7.jpg', 'award_2_bannerProfile.jpg', '2022-07-11 15:17:33'),
(3, 4, 'Ben', '', 'Jacobs', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Being robust &amp; feature pack CMS, Magento is serving tons of options as a part of the community edition to fulfill the needs of a store owner. Products and services sold within the store are assets and identity of the organization. Selling these stuff online, the product images, videos, docs and descriptions that are given on product page is helpful for the store owner to sell their product</span></p>', 'base_3_trainer2.png', '<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Training Name Duration Start -/ End date Location</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Training Name Duration Start -/ End date Location</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Training Name Duration Start -/ End date Location</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Training Name Duration Start -/ End date Location</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>', 'profile_3_trainer2.jpg', 'award_3_bannerProfile.jpg', '2022-07-20 10:53:05'),
(4, 6, 'James', '', ' ', '<p><strong style=\"box-sizing: border-box; color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\"> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</span></p>', 'base_4_trainer2.png', 'null', 'profile_4_trainer2_2.jpg', 'award_4_bannerProfile.jpg', '2022-07-20 11:48:41'),
(5, 7, 'Jon', '', 'Hung', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Being robust &amp; feature pack CMS, Magento is serving tons of options as a part of the community edition to fulfill the needs of a store owner. Products and services sold within the store are assets and identity of the organization. Selling these stuff online, the product images, videos, docs and descriptions that are given on product page is helpful for the store owner to sell their product</span></p>', 'base_5_trainer3.png', '<p><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary</span></p>', 'profile_5_trainer3.jpg', 'award_5_bannerProfile.jpg', '2022-07-20 12:20:25'),
(6, 8, 'Jose', '', 'Alexandro', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Being robust &amp; feature pack CMS, Magento is serving tons of options as a part of the community edition to fulfill the needs of a store owner. Products and services sold within the store are assets and identity of the organization. Selling these stuff online, the product images, videos, docs and descriptions that are given on product page is helpful for the store owner to sell their product</span></p>', 'base_6_trainer4.png', '<p><strong style=\"margin: 0px; padding: 0px; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</span></p>', 'profile_6_trainer4.jpg', 'award_6_bannerProfile.jpg', '2022-07-20 12:48:59'),
(7, 9, 'Manish', '', '  ', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful.</span></p>', 'base_7_trainer2.png', '<p><strong style=\"margin: 0px; padding: 0px; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</span></p>', 'profile_7_trainer2_2.jpg', 'award_7_bannerProfile.jpg', '2022-07-20 13:24:21'),
(8, 10, 'Marciano ', ' Soto', 'Pavon', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Share my professional experience in design, implementation, maintenance and training in Business Communications Networks and in a Call Center environment.</span></p>', 'base_8_marciano-profile_1.png', '<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Free Lance Instructor January 2016&nbsp;-/ April 2019</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Deliver Avaya training on site and virtual. Training developer for Avaya team engagement solutions</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">ACSS-7290 Avaya Enterprise Team Engagement Solution certification. AIPS IP Office</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">AVAYA Communications de M&eacute;xico, S.A December 2012 -/ December 2015</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">As a training manager I managed to increase enrollment to courses and consequently billing by 75%</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">As an instructor I got the certifications in three technologies, Avaya Aura Contact Center, AES and IP Telephony</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Huawei January 2012-/ September 2012&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">VoIP Technical instructor. Develop a certification exam for Huawei Unified Communications that was applied to 5 Business Partners.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Participate as installation coordinator in an IP Telephony implementation for a government office where 5000 IP endpoints were installed</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Summaria Networks October 2010&nbsp;-/ December 2011&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Deliver Avaya training globally. Implementation Design and Sales curriculums</p>\r\n</div>', 'profile_8_bg_6.jpg', 'award_8_bannerProfile.jpg', '2022-07-20 13:55:49'),
(9, 11, 'Miguel ', '', 'Sarabia', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Miguel Sarabia is a soft skills trainer based in Budapest, Hungary since 2001. He specialises in negotiations skills, leadership techniques, sales and communications training. He applies his knowledge and experience in an extremely engaging and energetic way to help managers and line staff bring out the most of what they are capable of.</span></p>', 'base_9_miguel.png', '<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Manufacturing Industries 2001/ 2018 Hungary</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Interpersonal Communication Skills and Assertiveness training for managers at Budapest shared services centres of several multinationals</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Negotiations Skills 2005 - 2017, Boston</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Delivery of Negotiations Skills training in Europe on behalf of a Boston &ndash; based company</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Banking Duration 2003 - 2020 Boston</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Banking Financial training - Bank Austria , West LB</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">hospitality industry 2007 - 2020 Boston</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Leadership training for Management of several five star hotels</p>\r\n</div>', 'profile_9_bg_5.jpg', 'award_9_bannerProfile.jpg', '2022-07-20 15:06:06'),
(10, 12, 'ROBIN ', '', 'AGUIRRE', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">TRAINING &amp; DEVELOPMENT &ndash; COURSE / NETWORKING &amp; COMMUNICATIONS / MATERIAL DEVELOPMENT &ndash; ACCOUNT MANAGEMENT PRODUCT MARKETING &ndash; WRITING / COMMUNICATIONS &ndash; SOFTWARE DEVELOPMENT &ndash; SYSTEM INSTALLATION PRODUCT DEVELOPMENT &amp; LAUNCH &ndash; RESEARCH &amp; DEVELOPMENT &ndash; TEAM LEADERSHIP &ndash; CLIENT RELATIONS&nbsp;&nbsp;</span></p>', 'base_10_circle-cropped_1_.png', '<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">PRINCIPAL TECHNICAL TRAINER &ndash; GLOBAL KNOWLEDGE | 2004 - Present</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Provide training for three major product lines: Avaya, IBM, and Cisco lines of business; create and deliver courses that generate more than $35M in annual revenue for a $325M corporation.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Develop and lead Avaya Enterprise Solutions Training classes for customers and partners, delivering courses on-site, virtually, and at company training facilities nationwide; technical courses include software, hardware, configuration, administration, and maintenance of the Avaya product line.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">PRINCIPAL TECHNICAL ADVISER/COURSE DEVELOPER &ndash; GLOBAL KNOWLEDGE | 2000-2004</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Retained when Nortel sold its training group to Global Knowledge, serving as an instructor and course developer for multiple product lines.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Served as Technical Advisor and Course Developer for Nortel Enterprise Solutions, providing instructional courses for both internal and external Nortel customers.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">SENIOR TECHNICAL TRAINER/ARCHITECT &ndash; NORTEL NETWORKS | 1992-2000</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Served as hardware/software technical trainer and writer for Nortel Enterprise Solution Training.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Served as hardware/software technical trainer and writer for Nortel Enterprise Solution Training.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Recognized as a Subject Matter Expert for the Meridian 1 PBXs on various software releases</p>\r\n</div>', 'profile_10_robin_aguirre.jpg', 'award_10_bannerProfile.jpg', '2022-07-20 15:31:39');

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
(43, 1, '10th Grade', 1975, '2022-07-13 08:42:14'),
(44, 1, '12th Grade', 1989, '2022-07-13 08:42:14'),
(45, 1, 'Graduation', 1987, '2022-07-13 08:42:14'),
(46, 1, 'Post-Graduation', 1990, '2022-07-13 08:42:14'),
(47, 1, 'Professional Degree', 1995, '2022-07-13 08:42:14'),
(48, 1, 'PhD', 1996, '2022-07-13 08:42:14'),
(49, 2, '10th Grade', 1975, '2022-07-13 16:37:39'),
(50, 2, '12th Grade', 1989, '2022-07-13 16:37:39'),
(51, 2, 'Graduation', 1987, '2022-07-13 16:37:39'),
(52, 2, 'Post-Graduation', 1990, '2022-07-13 16:37:39'),
(53, 2, 'Professional Degree', 1995, '2022-07-13 16:37:39'),
(54, 2, 'PhD', 1996, '2022-07-13 16:37:40'),
(55, 4, '10th Grade', 2000, '2022-07-20 11:01:28'),
(56, 4, '12th Grade', 2002, '2022-07-20 11:01:28'),
(57, 4, 'Graduation', 2005, '2022-07-20 11:01:28'),
(58, 4, 'Post-Graduation', 2008, '2022-07-20 11:01:28'),
(59, 6, '10th Grade', 1990, '2022-07-20 11:59:01'),
(60, 6, '12th Grade', 1992, '2022-07-20 11:59:01'),
(61, 6, 'Graduation', 1995, '2022-07-20 11:59:01'),
(62, 6, 'Professional Degree', 1999, '2022-07-20 11:59:01'),
(63, 7, '10th Grade', 1979, '2022-07-20 12:24:03'),
(64, 7, '12th Grade', 1981, '2022-07-20 12:24:03'),
(65, 7, 'Graduation', 1984, '2022-07-20 12:24:03'),
(66, 7, 'Post-Graduation', 1987, '2022-07-20 12:24:03'),
(67, 7, 'PhD', 1992, '2022-07-20 12:24:03'),
(68, 8, '10th Grade', 1994, '2022-07-20 12:54:15'),
(69, 8, '12th Grade', 1996, '2022-07-20 12:54:15'),
(70, 8, 'Graduation', 1999, '2022-07-20 12:54:15'),
(71, 9, '10th Grade', 1989, '2022-07-20 13:34:21'),
(72, 9, '12th Grade', 1991, '2022-07-20 13:34:21'),
(73, 9, 'Graduation', 1994, '2022-07-20 13:34:21'),
(77, 10, '10th Grade', 1980, '2022-07-20 13:59:45'),
(78, 10, '12th Grade', 1982, '2022-07-20 13:59:45'),
(79, 10, 'Graduation', 1985, '2022-07-20 13:59:45'),
(80, 10, 'Post-Graduation', 1988, '2022-07-20 13:59:45'),
(81, 11, '10th Grade', 1990, '2022-07-20 15:09:45'),
(82, 11, '12th Grade', 1992, '2022-07-20 15:09:45'),
(83, 11, 'Graduation', 1995, '2022-07-20 15:09:45'),
(84, 12, '10th Grade', 1982, '2022-07-20 15:39:12'),
(85, 12, '12th Grade', 1984, '2022-07-20 15:39:12'),
(86, 12, 'Graduation', 1987, '2022-07-20 15:39:12'),
(87, 12, 'Post-Graduation', 1990, '2022-07-20 15:39:12');

-- --------------------------------------------------------

--
-- Table structure for table `trainer_awards`
--

CREATE TABLE `trainer_awards` (
  `id` bigint(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `award` varchar(255) NOT NULL,
  `organisation` varchar(255) NOT NULL,
  `year` int(4) NOT NULL,
  `url` text,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `trainer_awards`
--

INSERT INTO `trainer_awards` (`id`, `user_id`, `award`, `organisation`, `year`, `url`, `created_at`) VALUES
(7, 1, 'MS DOS CertifiCation', 'MS DOS CertifiCation', 1972, 'website url', '2022-07-11 12:42:38'),
(8, 1, 'C++ Certification', 'C++ Certification', 1973, 'website url', '2022-07-11 12:42:38'),
(9, 1, 'Python Certification', 'Python Certification', 1974, 'website url', '2022-07-11 12:42:38'),
(10, 1, 'Solaries Certification', 'Solaries Certification', 1975, 'website url', '2022-07-11 12:42:39'),
(15, 2, 'Certified Contact Center Excellence Registered Coordinator (COPC Inc)', 'Certified Contact Center Excellence Registered Coordinator (COPC Inc)', 2000, NULL, '2022-07-13 16:56:57'),
(16, 2, 'Certified Sales & Leadership Professional', 'Certified Sales & Leadership Professional', 2005, NULL, '2022-07-13 16:56:57'),
(17, 2, 'Certified Train-the-Trainer', 'Certified Train-the-Trainer', 2006, NULL, '2022-07-13 16:56:57'),
(18, 2, 'Certified Leadership Speaker & Trainer', 'Certified Leadership Speaker & Trainer', 2007, NULL, '2022-07-13 16:56:57'),
(19, 2, 'Certified Sales Trainer for HP Global Sales Program', 'Certified Sales Trainer for HP Global Sales Program', 2010, NULL, '2022-07-13 16:56:57'),
(25, 4, 'Project Awards', 'Project Awards', 2006, 'Credential URL', '2022-07-20 11:08:31'),
(26, 4, 'Editor’s Choice Award', 'Editor’s Choice Award', 2007, 'Credential URL', '2022-07-20 11:08:31'),
(27, 4, ' Manufacturing Leader of the Year awards', ' Manufacturing Leader of the Year awards', 2011, 'Credential URL', '2022-07-20 11:08:31'),
(28, 4, 'Technology and Consulting Partners', 'Technology and Consulting Partners', 2014, 'Credential URL', '2022-07-20 11:08:31'),
(29, 4, 'Lifetime Achievement Award', 'Lifetime Achievement Award', 2021, 'Credential URL', '2022-07-20 11:08:31'),
(30, 6, 'Individual Awards', 'Individual Awards', 2005, 'Credential URL', '2022-07-20 12:04:13'),
(31, 6, 'Technology and Consulting Partners ', 'Technology and Consulting Partners ', 2010, 'Credential URL', '2022-07-20 12:04:13'),
(32, 6, 'Project (Company) Awards ', 'Project (Company) Awards ', 2016, 'Credential URL', '2022-07-20 12:04:13'),
(33, 6, 'Lifetime Achievement Award ', 'Lifetime Achievement Award ', 2020, 'Credential URL', '2022-07-20 12:04:13'),
(34, 7, 'Individual Awards', 'Individual Awards', 1995, 'Credential URL', '2022-07-20 12:25:53'),
(35, 7, 'Technology and Consulting Partners', 'Technology and Consulting Partners', 1999, 'Credential URL', '2022-07-20 12:25:53'),
(36, 7, 'Editor’s Choice Award', 'Editor’s Choice Award', 2007, 'Credential URL', '2022-07-20 12:25:53'),
(37, 7, 'Lifetime Achievement Award ', 'Lifetime Achievement Award ', 2018, 'Credential URL', '2022-07-20 12:25:53'),
(38, 8, 'Project (Company) Awards', 'Project (Company) Awards', 2012, 'Credential URL', '2022-07-20 12:56:08'),
(39, 8, 'Individual Awards', 'Individual Awards', 2016, 'Credential URL', '2022-07-20 12:56:08'),
(40, 8, 'Editor’s Choice Award ', 'Editor’s Choice Award ', 2020, 'Credential URL', '2022-07-20 12:56:08'),
(41, 9, 'Project (Company) Awards ', 'Project (Company) Awards ', 1998, 'Credential URL', '2022-07-20 13:36:51'),
(42, 9, 'Individual Awards', 'Individual Awards', 2001, 'Credential URL', '2022-07-20 13:36:51'),
(43, 9, 'Editor’s Choice Award', 'Editor’s Choice Award', 2007, 'Credential URL', '2022-07-20 13:36:51'),
(44, 9, 'Manufacturing Leader of the Year ', 'Manufacturing Leader of the Year ', 2012, 'Credential URL', '2022-07-20 13:36:51'),
(45, 9, 'Lifetime Achievement Award', 'Lifetime Achievement Award', 2020, 'Credential URL', '2022-07-20 13:36:51'),
(46, 10, '–Avaya Team Engagement Certification', '–Avaya Team Engagement Certification', 2007, 'Credential URL', '2022-07-20 14:02:58'),
(47, 10, 'Training Centre Management” Certification', 'Training Centre Management” Certification', 2010, 'Credential URL', '2022-07-20 14:02:58'),
(48, 11, '- Project Management certificate', '- Project Management certificate', 2005, 'Credential URL', '2022-07-20 15:16:20'),
(49, 11, '– • Qualified Myers-Briggs Type Indicator Practitioner. Step 1', '– • Qualified Myers-Briggs Type Indicator Practitioner. Step 1', 2007, 'Credential URL', '2022-07-20 15:16:20'),
(50, 12, '– Avaya Aura Communication Manager and Avaya Communication Server 1000E ', '– Avaya Aura Communication Manager and Avaya Communication Server 1000E ', 2010, 'Credential URL', '2022-07-20 15:43:58'),
(51, 12, '– Avaya Aura System & Session Manager and Avaya Aura Call Center Elite Member, International Avaya Aura Users Group', '– Avaya Aura System & Session Manager and Avaya Aura Call Center Elite Member, International Avaya Aura Users Group', 2012, 'Credential URL', '2022-07-20 15:43:58'),
(52, 12, '– Avaya Aura System & Session Manager and Avaya Aura Call Center Elite Member, International Avaya Aura Users Group', '– Avaya Aura System & Session Manager and Avaya Aura Call Center Elite Member, International Avaya Aura Users Group', 2012, 'Credential URL', '2022-07-20 15:43:58'),
(53, 12, '– Avaya Aura Communication Manager and Avaya Communication Server 1000E |', '– Avaya Aura Communication Manager and Avaya Communication Server 1000E |', 2015, 'Credential URL', '2022-07-20 15:43:58');

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
(88, 1, 99, 102, '2022-07-08 10:10:21'),
(89, 2, 1, 2, '2022-07-11 16:03:00'),
(90, 2, 1, 3, '2022-07-11 16:03:00'),
(91, 2, 1, 4, '2022-07-11 16:03:00'),
(92, 2, 1, 6, '2022-07-11 16:03:00'),
(93, 2, 1, 7, '2022-07-11 16:03:01'),
(94, 2, 1, 8, '2022-07-11 16:03:01'),
(95, 2, 1, 10, '2022-07-11 16:03:01'),
(96, 2, 1, 11, '2022-07-11 16:03:01'),
(97, 2, 1, 12, '2022-07-11 16:03:01'),
(98, 2, 18, 20, '2022-07-11 16:03:01'),
(99, 2, 18, 21, '2022-07-11 16:03:01'),
(100, 2, 18, 22, '2022-07-11 16:03:01'),
(101, 2, 18, 23, '2022-07-11 16:03:01'),
(102, 2, 25, 26, '2022-07-11 16:03:01'),
(103, 2, 25, 27, '2022-07-11 16:03:01'),
(104, 2, 25, 28, '2022-07-11 16:03:01'),
(105, 2, 44, 46, '2022-07-11 16:03:01'),
(106, 2, 44, 47, '2022-07-11 16:03:01'),
(107, 2, 44, 48, '2022-07-11 16:03:01'),
(108, 2, 44, 49, '2022-07-11 16:03:01'),
(109, 2, 44, 50, '2022-07-11 16:03:01'),
(110, 2, 51, 52, '2022-07-11 16:03:01'),
(111, 2, 51, 53, '2022-07-11 16:03:01'),
(112, 2, 51, 54, '2022-07-11 16:03:01'),
(113, 2, 56, 57, '2022-07-11 16:03:02'),
(114, 2, 68, 69, '2022-07-11 16:03:02'),
(115, 2, 68, 70, '2022-07-11 16:03:02'),
(116, 2, 74, 76, '2022-07-11 16:03:02'),
(117, 2, 83, 85, '2022-07-11 16:03:02'),
(118, 2, 83, 86, '2022-07-11 16:03:02'),
(119, 2, 91, 92, '2022-07-11 16:03:02'),
(120, 2, 91, 93, '2022-07-11 16:03:02'),
(121, 2, 99, 100, '2022-07-11 16:03:02'),
(122, 2, 99, 101, '2022-07-11 16:03:02'),
(123, 2, 99, 102, '2022-07-11 16:03:02'),
(124, 4, 1, 6, '2022-07-20 10:59:47'),
(125, 4, 18, 19, '2022-07-20 10:59:48'),
(126, 4, 18, 20, '2022-07-20 10:59:48'),
(127, 4, 18, 22, '2022-07-20 10:59:48'),
(128, 4, 18, 23, '2022-07-20 10:59:48'),
(129, 4, 25, 27, '2022-07-20 10:59:48'),
(130, 4, 25, 28, '2022-07-20 10:59:48'),
(131, 4, 25, 30, '2022-07-20 10:59:48'),
(132, 4, 25, 31, '2022-07-20 10:59:48'),
(133, 4, 25, 33, '2022-07-20 10:59:48'),
(134, 4, 25, 35, '2022-07-20 10:59:48'),
(135, 4, 25, 37, '2022-07-20 10:59:48'),
(136, 4, 25, 38, '2022-07-20 10:59:48'),
(137, 4, 25, 40, '2022-07-20 10:59:48'),
(138, 4, 25, 42, '2022-07-20 10:59:48'),
(139, 4, 44, 45, '2022-07-20 10:59:48'),
(140, 4, 44, 47, '2022-07-20 10:59:48'),
(141, 4, 51, 53, '2022-07-20 10:59:48'),
(142, 4, 56, 57, '2022-07-20 10:59:48'),
(143, 4, 68, 69, '2022-07-20 10:59:48'),
(144, 4, 74, 76, '2022-07-20 10:59:48'),
(145, 4, 83, 84, '2022-07-20 10:59:48'),
(146, 4, 83, 85, '2022-07-20 10:59:48'),
(147, 4, 91, 92, '2022-07-20 10:59:48'),
(148, 4, 91, 93, '2022-07-20 10:59:48'),
(149, 4, 99, 101, '2022-07-20 10:59:48'),
(150, 4, 99, 102, '2022-07-20 10:59:48'),
(151, 4, 99, 104, '2022-07-20 10:59:48'),
(308, 6, 1, 10, '2022-07-20 12:16:37'),
(309, 6, 18, 19, '2022-07-20 12:16:37'),
(310, 6, 18, 20, '2022-07-20 12:16:37'),
(311, 6, 18, 21, '2022-07-20 12:16:37'),
(312, 6, 18, 22, '2022-07-20 12:16:37'),
(313, 6, 18, 23, '2022-07-20 12:16:37'),
(314, 6, 25, 26, '2022-07-20 12:16:37'),
(315, 6, 25, 27, '2022-07-20 12:16:37'),
(316, 6, 25, 28, '2022-07-20 12:16:37'),
(317, 6, 25, 29, '2022-07-20 12:16:37'),
(318, 6, 25, 30, '2022-07-20 12:16:37'),
(319, 6, 25, 31, '2022-07-20 12:16:37'),
(320, 6, 25, 33, '2022-07-20 12:16:37'),
(321, 6, 25, 34, '2022-07-20 12:16:37'),
(322, 6, 25, 35, '2022-07-20 12:16:37'),
(323, 6, 25, 37, '2022-07-20 12:16:37'),
(324, 6, 25, 38, '2022-07-20 12:16:37'),
(325, 6, 25, 40, '2022-07-20 12:16:37'),
(326, 6, 25, 42, '2022-07-20 12:16:37'),
(327, 6, 44, 45, '2022-07-20 12:16:37'),
(328, 6, 44, 46, '2022-07-20 12:16:37'),
(329, 6, 44, 47, '2022-07-20 12:16:37'),
(330, 6, 44, 48, '2022-07-20 12:16:37'),
(331, 6, 44, 49, '2022-07-20 12:16:37'),
(332, 6, 44, 50, '2022-07-20 12:16:37'),
(333, 6, 51, 52, '2022-07-20 12:16:37'),
(334, 6, 51, 53, '2022-07-20 12:16:37'),
(335, 6, 51, 54, '2022-07-20 12:16:37'),
(336, 6, 51, 55, '2022-07-20 12:16:37'),
(337, 6, 56, 57, '2022-07-20 12:16:37'),
(338, 6, 56, 58, '2022-07-20 12:16:37'),
(339, 6, 68, 69, '2022-07-20 12:16:37'),
(340, 6, 68, 70, '2022-07-20 12:16:37'),
(341, 6, 74, 76, '2022-07-20 12:16:37'),
(342, 6, 83, 84, '2022-07-20 12:16:37'),
(343, 6, 83, 85, '2022-07-20 12:16:37'),
(344, 6, 83, 86, '2022-07-20 12:16:37'),
(345, 6, 91, 92, '2022-07-20 12:16:37'),
(346, 6, 91, 93, '2022-07-20 12:16:37'),
(347, 6, 99, 100, '2022-07-20 12:16:37'),
(348, 6, 99, 101, '2022-07-20 12:16:37'),
(349, 6, 99, 102, '2022-07-20 12:16:37'),
(350, 6, 99, 103, '2022-07-20 12:16:37'),
(351, 6, 99, 104, '2022-07-20 12:16:37'),
(352, 6, 99, 105, '2022-07-20 12:16:37'),
(378, 8, 1, 2, '2022-07-20 12:53:21'),
(379, 8, 1, 6, '2022-07-20 12:53:21'),
(380, 8, 18, 21, '2022-07-20 12:53:21'),
(381, 8, 18, 22, '2022-07-20 12:53:21'),
(382, 8, 25, 26, '2022-07-20 12:53:21'),
(383, 8, 25, 27, '2022-07-20 12:53:21'),
(384, 8, 25, 28, '2022-07-20 12:53:21'),
(385, 8, 25, 30, '2022-07-20 12:53:21'),
(386, 8, 25, 31, '2022-07-20 12:53:21'),
(387, 8, 25, 32, '2022-07-20 12:53:21'),
(388, 8, 25, 35, '2022-07-20 12:53:21'),
(389, 8, 44, 48, '2022-07-20 12:53:21'),
(390, 8, 44, 49, '2022-07-20 12:53:21'),
(391, 8, 44, 50, '2022-07-20 12:53:21'),
(392, 8, 51, 52, '2022-07-20 12:53:21'),
(393, 8, 56, 57, '2022-07-20 12:53:21'),
(394, 8, 68, 72, '2022-07-20 12:53:21'),
(395, 8, 74, 76, '2022-07-20 12:53:21'),
(396, 8, 83, 84, '2022-07-20 12:53:21'),
(397, 8, 83, 87, '2022-07-20 12:53:21'),
(398, 8, 91, 92, '2022-07-20 12:53:21'),
(399, 8, 99, 100, '2022-07-20 12:53:21'),
(400, 8, 99, 101, '2022-07-20 12:53:21'),
(401, 8, 99, 102, '2022-07-20 12:53:21'),
(402, 8, 99, 103, '2022-07-20 12:53:21'),
(403, 8, 99, 104, '2022-07-20 12:53:21'),
(404, 8, 99, 105, '2022-07-20 12:53:21'),
(405, 7, 1, 12, '2022-07-20 13:25:42'),
(406, 7, 18, 19, '2022-07-20 13:25:42'),
(407, 7, 18, 20, '2022-07-20 13:25:42'),
(408, 7, 18, 21, '2022-07-20 13:25:42'),
(409, 7, 18, 22, '2022-07-20 13:25:42'),
(410, 7, 18, 23, '2022-07-20 13:25:42'),
(411, 7, 25, 26, '2022-07-20 13:25:42'),
(412, 7, 25, 27, '2022-07-20 13:25:42'),
(413, 7, 25, 28, '2022-07-20 13:25:42'),
(414, 7, 25, 29, '2022-07-20 13:25:42'),
(415, 7, 25, 30, '2022-07-20 13:25:42'),
(416, 7, 25, 31, '2022-07-20 13:25:42'),
(417, 7, 25, 32, '2022-07-20 13:25:42'),
(418, 7, 25, 33, '2022-07-20 13:25:42'),
(419, 7, 25, 34, '2022-07-20 13:25:42'),
(420, 7, 25, 35, '2022-07-20 13:25:42'),
(421, 7, 25, 36, '2022-07-20 13:25:42'),
(422, 7, 25, 37, '2022-07-20 13:25:42'),
(423, 7, 25, 38, '2022-07-20 13:25:42'),
(424, 7, 25, 40, '2022-07-20 13:25:42'),
(425, 7, 25, 42, '2022-07-20 13:25:42'),
(426, 7, 44, 45, '2022-07-20 13:25:42'),
(427, 7, 44, 46, '2022-07-20 13:25:42'),
(428, 7, 44, 47, '2022-07-20 13:25:42'),
(429, 7, 44, 48, '2022-07-20 13:25:42'),
(430, 7, 44, 49, '2022-07-20 13:25:42'),
(431, 7, 44, 50, '2022-07-20 13:25:42'),
(432, 7, 51, 52, '2022-07-20 13:25:42'),
(433, 7, 51, 53, '2022-07-20 13:25:42'),
(434, 7, 51, 54, '2022-07-20 13:25:42'),
(435, 7, 51, 55, '2022-07-20 13:25:42'),
(436, 7, 56, 57, '2022-07-20 13:25:42'),
(437, 7, 56, 58, '2022-07-20 13:25:42'),
(438, 7, 68, 69, '2022-07-20 13:25:42'),
(439, 7, 68, 70, '2022-07-20 13:25:42'),
(440, 7, 68, 72, '2022-07-20 13:25:42'),
(441, 7, 74, 76, '2022-07-20 13:25:42'),
(442, 7, 83, 84, '2022-07-20 13:25:42'),
(443, 7, 83, 85, '2022-07-20 13:25:42'),
(444, 7, 83, 86, '2022-07-20 13:25:42'),
(445, 7, 83, 87, '2022-07-20 13:25:42'),
(446, 7, 91, 92, '2022-07-20 13:25:42'),
(447, 7, 91, 93, '2022-07-20 13:25:42'),
(448, 7, 99, 100, '2022-07-20 13:25:42'),
(449, 7, 99, 101, '2022-07-20 13:25:42'),
(450, 7, 99, 102, '2022-07-20 13:25:42'),
(451, 7, 99, 103, '2022-07-20 13:25:42'),
(452, 7, 99, 104, '2022-07-20 13:25:42'),
(453, 7, 99, 105, '2022-07-20 13:25:42'),
(498, 9, 1, 2, '2022-07-20 13:33:53'),
(499, 9, 1, 3, '2022-07-20 13:33:53'),
(500, 9, 1, 4, '2022-07-20 13:33:53'),
(501, 9, 1, 5, '2022-07-20 13:33:53'),
(502, 9, 1, 6, '2022-07-20 13:33:54'),
(503, 9, 1, 7, '2022-07-20 13:33:54'),
(504, 9, 1, 8, '2022-07-20 13:33:54'),
(505, 9, 1, 10, '2022-07-20 13:33:54'),
(506, 9, 1, 11, '2022-07-20 13:33:54'),
(507, 9, 1, 12, '2022-07-20 13:33:54'),
(508, 9, 1, 14, '2022-07-20 13:33:54'),
(509, 9, 18, 19, '2022-07-20 13:33:54'),
(510, 9, 18, 20, '2022-07-20 13:33:54'),
(511, 9, 18, 21, '2022-07-20 13:33:54'),
(512, 9, 18, 22, '2022-07-20 13:33:54'),
(513, 9, 18, 23, '2022-07-20 13:33:54'),
(514, 9, 25, 26, '2022-07-20 13:33:54'),
(515, 9, 25, 27, '2022-07-20 13:33:54'),
(516, 9, 25, 28, '2022-07-20 13:33:54'),
(517, 9, 25, 29, '2022-07-20 13:33:54'),
(518, 9, 25, 30, '2022-07-20 13:33:54'),
(519, 9, 25, 31, '2022-07-20 13:33:54'),
(520, 9, 25, 32, '2022-07-20 13:33:54'),
(521, 9, 25, 33, '2022-07-20 13:33:54'),
(522, 9, 25, 34, '2022-07-20 13:33:54'),
(523, 9, 25, 35, '2022-07-20 13:33:54'),
(524, 9, 25, 36, '2022-07-20 13:33:54'),
(525, 9, 25, 37, '2022-07-20 13:33:54'),
(526, 9, 25, 38, '2022-07-20 13:33:54'),
(527, 9, 25, 40, '2022-07-20 13:33:54'),
(528, 9, 25, 42, '2022-07-20 13:33:54'),
(529, 9, 44, 45, '2022-07-20 13:33:54'),
(530, 9, 44, 46, '2022-07-20 13:33:54'),
(531, 9, 44, 47, '2022-07-20 13:33:54'),
(532, 9, 44, 48, '2022-07-20 13:33:54'),
(533, 9, 44, 49, '2022-07-20 13:33:54'),
(534, 9, 44, 50, '2022-07-20 13:33:54'),
(535, 9, 51, 52, '2022-07-20 13:33:54'),
(536, 9, 51, 53, '2022-07-20 13:33:54'),
(537, 9, 56, 57, '2022-07-20 13:33:54'),
(538, 9, 56, 58, '2022-07-20 13:33:54'),
(539, 9, 68, 69, '2022-07-20 13:33:54'),
(540, 9, 68, 70, '2022-07-20 13:33:54'),
(541, 9, 68, 72, '2022-07-20 13:33:54'),
(542, 9, 74, 76, '2022-07-20 13:33:54'),
(543, 9, 83, 84, '2022-07-20 13:33:54'),
(544, 9, 83, 85, '2022-07-20 13:33:54'),
(545, 9, 83, 86, '2022-07-20 13:33:54'),
(546, 9, 83, 87, '2022-07-20 13:33:54'),
(547, 9, 83, 88, '2022-07-20 13:33:54'),
(548, 9, 91, 92, '2022-07-20 13:33:54'),
(549, 9, 91, 93, '2022-07-20 13:33:54'),
(550, 9, 99, 100, '2022-07-20 13:33:54'),
(551, 9, 99, 101, '2022-07-20 13:33:54'),
(552, 9, 99, 102, '2022-07-20 13:33:54'),
(553, 9, 99, 103, '2022-07-20 13:33:54'),
(554, 9, 99, 104, '2022-07-20 13:33:54'),
(555, 9, 99, 105, '2022-07-20 13:33:54'),
(556, 10, 1, 3, '2022-07-20 13:58:50'),
(557, 10, 18, 19, '2022-07-20 13:58:50'),
(558, 10, 18, 20, '2022-07-20 13:58:50'),
(559, 10, 18, 22, '2022-07-20 13:58:50'),
(560, 10, 25, 26, '2022-07-20 13:58:50'),
(561, 10, 25, 32, '2022-07-20 13:58:50'),
(562, 10, 25, 33, '2022-07-20 13:58:50'),
(563, 10, 25, 36, '2022-07-20 13:58:50'),
(564, 10, 25, 37, '2022-07-20 13:58:50'),
(565, 10, 25, 42, '2022-07-20 13:58:50'),
(566, 10, 44, 45, '2022-07-20 13:58:50'),
(567, 10, 44, 46, '2022-07-20 13:58:50'),
(568, 10, 44, 47, '2022-07-20 13:58:50'),
(569, 10, 44, 48, '2022-07-20 13:58:50'),
(570, 10, 51, 52, '2022-07-20 13:58:50'),
(571, 10, 51, 53, '2022-07-20 13:58:50'),
(572, 10, 56, 57, '2022-07-20 13:58:50'),
(573, 10, 68, 69, '2022-07-20 13:58:50'),
(574, 10, 74, 76, '2022-07-20 13:58:50'),
(575, 10, 83, 84, '2022-07-20 13:58:50'),
(576, 10, 83, 85, '2022-07-20 13:58:50'),
(577, 10, 91, 92, '2022-07-20 13:58:50'),
(578, 10, 91, 93, '2022-07-20 13:58:50'),
(579, 10, 99, 100, '2022-07-20 13:58:50'),
(580, 10, 99, 101, '2022-07-20 13:58:50'),
(581, 10, 99, 102, '2022-07-20 13:58:50'),
(582, 10, 99, 103, '2022-07-20 13:58:50'),
(583, 10, 99, 104, '2022-07-20 13:58:50'),
(584, 10, 99, 105, '2022-07-20 13:58:50'),
(585, 11, 1, 6, '2022-07-20 15:08:43'),
(586, 11, 18, 21, '2022-07-20 15:08:43'),
(587, 11, 18, 22, '2022-07-20 15:08:43'),
(588, 11, 18, 23, '2022-07-20 15:08:43'),
(589, 11, 18, 24, '2022-07-20 15:08:43'),
(590, 11, 25, 27, '2022-07-20 15:08:43'),
(591, 11, 25, 28, '2022-07-20 15:08:43'),
(592, 11, 25, 31, '2022-07-20 15:08:43'),
(593, 11, 25, 33, '2022-07-20 15:08:43'),
(594, 11, 44, 48, '2022-07-20 15:08:43'),
(595, 11, 51, 52, '2022-07-20 15:08:43'),
(596, 11, 51, 53, '2022-07-20 15:08:43'),
(597, 11, 56, 57, '2022-07-20 15:08:43'),
(598, 11, 68, 69, '2022-07-20 15:08:43'),
(599, 11, 74, 76, '2022-07-20 15:08:43'),
(600, 11, 83, 84, '2022-07-20 15:08:43'),
(601, 11, 83, 86, '2022-07-20 15:08:43'),
(602, 11, 91, 92, '2022-07-20 15:08:43'),
(603, 11, 99, 100, '2022-07-20 15:08:43'),
(604, 11, 99, 102, '2022-07-20 15:08:43'),
(605, 11, 99, 105, '2022-07-20 15:08:43'),
(606, 12, 1, 3, '2022-07-20 15:38:33'),
(607, 12, 18, 20, '2022-07-20 15:38:33'),
(608, 12, 18, 22, '2022-07-20 15:38:33'),
(609, 12, 18, 24, '2022-07-20 15:38:33'),
(610, 12, 25, 27, '2022-07-20 15:38:33'),
(611, 12, 25, 28, '2022-07-20 15:38:33'),
(612, 12, 25, 31, '2022-07-20 15:38:33'),
(613, 12, 25, 33, '2022-07-20 15:38:33'),
(614, 12, 25, 37, '2022-07-20 15:38:33'),
(615, 12, 25, 39, '2022-07-20 15:38:33'),
(616, 12, 25, 42, '2022-07-20 15:38:33'),
(617, 12, 25, 43, '2022-07-20 15:38:33'),
(618, 12, 44, 45, '2022-07-20 15:38:33'),
(619, 12, 44, 46, '2022-07-20 15:38:33'),
(620, 12, 44, 47, '2022-07-20 15:38:33'),
(621, 12, 51, 53, '2022-07-20 15:38:33'),
(622, 12, 56, 57, '2022-07-20 15:38:33'),
(623, 12, 68, 69, '2022-07-20 15:38:33'),
(624, 12, 74, 76, '2022-07-20 15:38:33'),
(625, 12, 83, 84, '2022-07-20 15:38:33'),
(626, 12, 83, 85, '2022-07-20 15:38:33'),
(627, 12, 91, 92, '2022-07-20 15:38:33'),
(628, 12, 99, 101, '2022-07-20 15:38:34'),
(629, 12, 99, 103, '2022-07-20 15:38:34'),
(630, 12, 99, 105, '2022-07-20 15:38:34');

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

--
-- Dumping data for table `trainer_exp`
--

INSERT INTO `trainer_exp` (`id`, `user_id`, `company`, `location`, `created_at`) VALUES
(1, 1, 'Knowledge Synonyms', 'Noida, India', '2022-07-11 12:41:03'),
(2, 1, 'RepIndia', 'Delhi, India', '2022-07-11 12:41:05'),
(3, 1, 'Synapse India', 'Noida, India', '2022-07-11 12:41:05'),
(4, 1, 'Kelton Infotech', 'Gurgaon, India', '2022-07-11 12:41:05'),
(5, 1, 'CSC', 'Noida, India', '2022-07-11 12:41:05'),
(10, 2, 'John C. Maxwell Leadership Training', 'USA', '2022-07-13 16:50:59'),
(11, 2, 'HP Contractual Selling Training', 'USA', '2022-07-13 16:51:00'),
(12, 2, 'Doon Innovation Methodologies', 'USA', '2022-07-13 16:51:00'),
(13, 2, 'CCV', 'UK', '2022-07-13 16:51:00'),
(14, 4, 'Tech Mahendra', 'USA', '2022-07-20 11:02:57'),
(15, 4, 'IBM', 'USA', '2022-07-20 11:02:57'),
(16, 4, 'Huawei', 'USA', '2022-07-20 11:02:57'),
(17, 4, 'Summaria Network', 'USA', '2022-07-20 11:02:57'),
(18, 4, 'Accenture S.C', 'UK', '2022-07-20 11:02:57'),
(19, 6, 'IBM', 'USA', '2022-07-20 12:01:58'),
(20, 6, 'Accenture', 'UK', '2022-07-20 12:01:58'),
(21, 6, 'Wipro', 'USA', '2022-07-20 12:01:58'),
(22, 6, 'Google', 'USA', '2022-07-20 12:01:58'),
(23, 7, 'Wipro', 'USA', '2022-07-20 12:24:41'),
(24, 7, 'Accenture', 'UK', '2022-07-20 12:24:41'),
(25, 7, 'IBM', 'USA', '2022-07-20 12:24:41'),
(26, 7, 'Google', 'UK', '2022-07-20 12:24:41'),
(27, 7, 'Knowledge Synonyms', 'INDIA', '2022-07-20 12:24:41'),
(28, 8, 'Wipro', 'USA', '2022-07-20 12:54:59'),
(29, 8, 'Accenture', 'UK', '2022-07-20 12:54:59'),
(30, 8, 'IBM', 'USA', '2022-07-20 12:54:59'),
(31, 9, 'Wipro', 'USA', '2022-07-20 13:35:08'),
(32, 9, 'Accenture', 'USA', '2022-07-20 13:35:08'),
(33, 9, 'Google', 'UK', '2022-07-20 13:35:08'),
(34, 9, 'IBM', 'USA', '2022-07-20 13:35:08'),
(35, 9, 'Microsoft', 'UK', '2022-07-20 13:35:08'),
(36, 10, 'Free Lance  Instructor', 'USA', '2022-07-20 14:01:52'),
(37, 10, 'AVAYA Communications de México', 'SA', '2022-07-20 14:01:52'),
(38, 10, 'Huawei ', 'USA', '2022-07-20 14:01:52'),
(39, 10, 'Summaria Networks', 'USA', '2022-07-20 14:01:52'),
(40, 10, 'Accenture S.C', 'México', '2022-07-20 14:01:52'),
(41, 11, 'West LB', 'Hungary', '2022-07-20 15:14:41'),
(42, 11, 'Bank Austria', 'Hungary', '2022-07-20 15:14:41'),
(43, 11, 'Samsung', 'Uk', '2022-07-20 15:14:41'),
(44, 11, 'Hilton Hotels', 'UK', '2022-07-20 15:14:41'),
(45, 11, 'Wyndham Hotels', 'UK', '2022-07-20 15:14:41'),
(46, 11, 'Danone', 'UK', '2022-07-20 15:14:41'),
(47, 12, 'Cisco', 'USA', '2022-07-20 15:40:46'),
(48, 12, 'RealPage, Inc.', 'USA', '2022-07-20 15:40:46'),
(49, 12, 'Avaya', 'USA', '2022-07-20 15:40:46'),
(50, 12, 'Global Knowledge', 'USA', '2022-07-20 15:40:46'),
(51, 12, 'Nortel Networks', 'USA', '2022-07-20 15:40:46');

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
(1, 1, '<p>Omnis et atet labo. Nem quiamus, voloribus et omnihicatque volorpor accaeprat dolupta tibus, venimus dolorroris dollandam et aut di ne quaspis ea debitatur aute. Vit fugias dus aut reratiis ent eos ape...<br /><br />&ldquo;As ea perisque aut quibusamet as recto maximet ut ex excepere nobitatum consenes debis dolupta audit que volupta sitintorro et, nosandit mos estrunt.&rdquo;</p>', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">Omnis et atet labo. Nem quiamus, voloribus et omnihicatque vol- orpor accaeprat dolupta tibus, venimus. Rovid quia doluptatur as et, corem ent inversp.</span></p>', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">Omnis et atet labo. Nem quiamus, voloribus et omnihicatque vol- orpor accaeprat dolupta tibus, venimus. Rovid quia doluptatur as et, corem ent inversp.</span></p>', 'service__service-img.jpg', '2022-07-11 12:49:56'),
(2, 2, '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">Himli&rsquo;s passion and dedication in constantly striving for customer service and delivery excellence with effective leadership has been his trademark. Himli has won numerous international and regional awards for his contributions and achievements, including successful set up of the training function in Asia-Pacific with 6 strategic locations,&nbsp;</span><strong style=\"box-sizing: border-box; font-weight: bold; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">achieving the largest services sales and maintenance services deals in Asia-Pacific and many other successful sales wins with strategic US MNCs and local companies in ASEAN, India, China and Korea.</strong><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">&nbsp;His career highlights include receiving the prestigious MVP award for his training and leadership and contributions from Lucent Technologies, US.&nbsp; Himli was one of the 3 recipients globally to receive the top&nbsp;</span><em style=\"box-sizing: border-box; font-style: italic; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">e</em><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">Service Excellence Award in US from the CEO &amp; President of Avaya Inc for his regional leadership and management.&nbsp; He consistently achieved the highest customer service rating among support groups in Asia-Pacific. He was the President of the Employee Satisfaction Committee and was part of the strategic team for Change Management initiatives in Asia Pacific.</span></p>', '<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">-&nbsp;TetraMap Behaviour Profiling Training &ndash; Earth/Air/Water/Fire</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">&nbsp;- Doon Innovation Methodologies</p>\r\n<p>&nbsp;</p>', '<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">-&nbsp;Motivational Coaching &amp; Mentoring Programs</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">- Coaching for Impact Sales Manager Programs</p>\r\n<p>&nbsp;</p>', 'service__service-img_7.jpg', '2022-07-13 16:40:51'),
(4, 4, '<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Omnis et atet labo. Nem quiamus, voloribus et omnihicatque volorpor accaeprat dolupta tibus, venimus dolorroris dollandam et aut di ne quaspis ea debitatur aute. Vit fugias dus aut reratiis ent eos ape...</p>\r\n<p class=\"italicText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-style: italic; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&ldquo;As ea perisque aut quibusamet as recto maximet ut ex excepere nobitatum consenes debis dolupta audit que volupta sitintorro et, nosandit mos estrunt.&rdquo;</p>', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: italic; background-color: #ffffff;\">&ldquo;As ea perisque aut quibusamet as recto maximet ut ex excepere nobitatum consenes debis dolupta audit que volupta sitintorro et, nosandit mos estrunt.&rdquo;</span></p>', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Omnis et atet labo. Nem quiamus, voloribus et omnihicatque volorpor accaeprat dolupta tibus, venimus dolorroris dollandam et aut di ne quaspis ea debitatur aute.</span></p>', 'service__service-img_8.jpg', '2022-07-20 11:09:34'),
(5, 6, '<p><strong style=\"margin: 0px; padding: 0px; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.&nbsp;</span></p>', '<p><strong style=\"margin: 0px; padding: 0px; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.&nbsp;</span></p>', '<p><strong style=\"margin: 0px; padding: 0px; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.&nbsp;</span></p>', 'service__service-img_8.jpg', '2022-07-20 12:07:24'),
(6, 7, '<p><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary</span></p>', '<p><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur</span></p>', '<p><strong style=\"margin: 0px; padding: 0px; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,</span></p>', 'service__service-img_8.jpg', '2022-07-20 12:26:49'),
(7, 7, '<p><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary</span></p>', '<p><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur</span></p>', '<p><strong style=\"margin: 0px; padding: 0px; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,</span></p>', 'service__service-img_8.jpg', '2022-07-20 12:27:32'),
(8, 8, '<p><strong style=\"margin: 0px; padding: 0px; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</span></p>', '<p><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English.</span></p>', '<p><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text.&nbsp;</span></p>', 'service__service-img_8.jpg', '2022-07-20 12:57:45'),
(9, 8, '<p><strong style=\"margin: 0px; padding: 0px; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</span></p>', '<p><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English.</span></p>', '<p><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text.&nbsp;</span></p>', 'service__service-img_8.jpg', '2022-07-20 12:58:34'),
(10, 9, '<p><strong style=\"margin: 0px; padding: 0px; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</span></p>', '<p><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur</span></p>', '<p><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\"</span></p>', 'service__service-img_8.jpg', '2022-07-20 13:40:27'),
(11, 10, '<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">-Regional Infrastructure Lead for Avaya University. 2002</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Manages the Avaya Americas Training Centers (Equipment and Infrastructure improvements)</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\"><strong style=\"box-sizing: border-box;\">AVAYA Communications de M&eacute;xico, S.A</strong>.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">-Training Center Manager for Avaya University, Mexico Training Center 2000-2002</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\"><strong style=\"box-sizing: border-box;\">Lucent Technologies BCS, M&eacute;xico</strong></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Voice Network Design Specialist 1995-1997</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;-&nbsp;Design and configuration of voice networks solutions.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Regional Instructor 1997-1998</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;-&nbsp;Deliver training in the CALA Area</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Training Center Manager, 1998-2000</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Manages the new Training Center, in this position I got the President Award for team excellence in 1999</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;- Tier 2 Technical Support in Mexico for associates and BP&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\"><strong style=\"box-sizing: border-box;\">AT&amp;T Mexico</strong></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\"><u style=\"box-sizing: border-box;\">Field Technician PABX Installation 1989-1992</u></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\"><u style=\"box-sizing: border-box;\">Voice Mail and PBX Technical support Tier 1, 1992-1995</u></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\"><u style=\"box-sizing: border-box;\">Implementation and management of the first Definity Network&nbsp; in Mexico (Comercial Mexicana, 14 sites). I got the AT&amp;T Vice President Award for leading this project.</u></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\"><u style=\"box-sizing: border-box;\">Technical assurance support in the second largest network in Mexico (National polytechnic Institute, IPN)</u></p>', '<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">-&nbsp;<strong style=\"box-sizing: border-box;\">AVAYA Communications de M&eacute;xico, S.A</strong></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">-&nbsp;<strong style=\"box-sizing: border-box;\">AT&amp;T Mexico</strong></p>', '<p><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\"</span></p>', 'service__service-img_8.jpg', '2022-07-20 14:03:48'),
(14, 11, '<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Prior to entering the field of people skills development, Miguel worked in private and public industry to attract foreign investment to underdeveloped countries. His extensive travel brought him to over 65 countries in addition to his native Canada where he further developed his ability to work with people and to bring out their potential.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Miguel delivers different trainings for different companies, small and large. Regardless, his trainings are noted for being experiential, enjoyable and impactful.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Outside training, Miguel has extensive volunteer work experience, athletic interests in Nordic sports, physical fitness and linguistic skills (fluent in Spanish, English, French and advanced in Hungarian).</p>', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;- Large scale leadership and supervisor skills training program for petrochemical company</span></p>', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">- Numerous Cultural Awareness trainings and coachings in many countries for Managers</span><br style=\"box-sizing: border-box; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\" /><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">- Leadership training for Management of several five star hotels</span></p>', 'service__service-img_8.jpg', '2022-07-20 15:19:30'),
(15, 12, '<p class=\"italicText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-style: italic; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Core Strengths: Training &amp; Development &ndash; Course / Material Development &ndash; Account Management Product Marketing &ndash; Writing / Communications &ndash; Software Development &ndash; System Installation Product Development &amp; Launch &ndash; Research &amp; Development &ndash; Team Leadership &ndash; Client Relations</p>\r\n<p class=\"italicText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-style: italic; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">&nbsp;</p>\r\n<ul style=\"box-sizing: border-box; margin: 0px; padding: 0px; list-style: none; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<li style=\"box-sizing: border-box; padding: 0px; margin: 0rem 0px 1rem; list-style: none;\">Sold and delivered training courses for Avaya, IBM, and Cisco lines of business, generating more than $35M in combined annual revenue; led courses in private, public, and virtual environments.</li>\r\n<li style=\"box-sizing: border-box; padding: 0px; margin: 0rem 0px 1rem; list-style: none;\">Traveled across the U.S. and internationally to deliver courses with an average class size of 12 students; led an average of 40 one-week courses per year.</li>\r\n<li style=\"box-sizing: border-box; padding: 0px; margin: 0rem 0px 1rem; list-style: none;\">Created and delivered dozens of virtual classes as well as on-site courses for clients such as UPS, CA Technologies, Miami-Dade Fire &amp; Rescue, Black Box, Northwestern Mutual, VOX, AT&amp;T, Wells Fargo, Century Link, Lantana, Princeton University, and various hospitals and military bases nationwide</li>\r\n<li style=\"box-sizing: border-box; padding: 0px; margin: 0rem 0px 1rem; list-style: none;\">Certified to teach Avaya Aura Communication Manager, System and Session Manager, Call Center Elite, Session Border Controller, CS 1000E, and CS 1000M administration/implementation courses</li>\r\n</ul>', '<p style=\"box-sizing: border-box; margin: 0px 0px 10px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">- Function as Technical Editor for course and lab materials for Avaya, IBM, and Cisco products; sell and deliver custom on-site training courses for each line of business</p>', '<p><span style=\"color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">- Retained when Nortel sold its training group to Global Knowledge, serving as an instructor and course developer for multiple product lines.</span></p>', 'service__bg_2.jpg', '2022-07-20 15:44:51');

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
(1, 4, 'Rajesh', 'Kumar', 'Rajesh', 'India', 'Noida', '201001', 'UP', '9871050857', 'rajeshs@knowledgesynonyms.net', '$2a$08$o2ehfV2AnmggjV/VDhEzkOQ3AREMXYIdpNXrxj9EnemQ0ViPLTGZa', '2022-05-24 18:52:42', NULL, NULL, NULL, NULL, 1),
(2, 4, 'NOORHIMLI (HIMLI) ', '', 'ALI', 'USA', '', '', '', '+1 123 3244 333', 'noorhimli@gmail.com', '$2a$08$E0R8iFAVVqzRpxyhrL1da..twBBgm2CTJeih1DP/vjxklCwr5G6jC', '2022-07-11 15:17:33', NULL, NULL, NULL, NULL, 1),
(3, 3, 'Umesh', '', 'Gupta', 'India', 'Noida', '', 'New Delhi', '9716209056', 'umeshg@knowledgesynonyms.com', '$2a$08$nJCjNFzSoilj6zfCYfUmR.Lhf7A2iGBcuzcF1HYDjPI9xeuqvOMRi', '2022-07-15 17:42:54', NULL, NULL, NULL, NULL, 1),
(4, 4, 'Ben', '', 'Jacobs', 'Germany', 'Germany', '', 'Germany', '9999999999', 'benjacobs@gmail.com', '$2a$08$pRE/mYVd3bmOU60UTqnDIuQcl9rkBB5thUp07uCI4CRQIfds/RhyC', '2022-07-20 10:53:05', NULL, NULL, NULL, NULL, 1),
(6, 4, 'James', '', ' ', 'USA', 'USA', '', 'USA', '9999999998', 'james@gmail.com', '$2a$08$/Li2VNCkoNEWwD4zF9X8D.M5TfSgZbxvp3JDP8BiXmThE1eXnVBRm', '2022-07-20 11:48:41', NULL, NULL, NULL, NULL, 1),
(7, 4, 'Jon', '', 'Hung', 'Canada', 'Canada', '', 'Canada', '9999999997', 'jonhung@gmail.com', '$2a$08$uRez.KyXgJ33OZMHh/x8/.OOORuD2iyU6XnRJdAW.FALT5qYHLjN2', '2022-07-20 12:20:25', NULL, NULL, NULL, NULL, 1),
(8, 4, 'Jose', '', 'Alexandro', 'France', 'France', '', 'France', '9999999994', 'josealexandro@gmail.com', '$2a$08$HFE88vZTAWOJacv4WGcXLubzkKPSpsiopjyUWndBeBdhI30nw1Spi', '2022-07-20 12:48:59', NULL, NULL, NULL, NULL, 1),
(9, 4, 'Manish', '', '  ', 'Canada', 'Canada', '', 'Canada', '9999999925', 'manish@gmail.com', '$2a$08$zgpnUmLFnrG7JdQXhpFSu.iDA7I2G3FYrZ1jJvNrZ2RRAg9ub6tF.', '2022-07-20 13:24:21', NULL, NULL, NULL, NULL, 1),
(10, 4, 'Marciano ', ' Soto', 'Pavon', 'USA', 'USA', '', 'USA', '9999999991', 'marciano@gmail.com', '$2a$08$Z/br4SROd1AuNBKR6FZImenQiIU.UiqpU0Rm1qO2QvXs26magwmly', '2022-07-20 13:55:49', NULL, NULL, NULL, NULL, 1),
(11, 4, 'Miguel ', '', 'Sarabia', 'Canada', 'Canada', '', 'Canada', '9999999992', 'miguel@gmail.com', '$2a$08$xiLCDSkqgaF7QZcVnLjfa.ntiFwoItxBpwA1TJZ4t55cuzv41MnFe', '2022-07-20 15:06:06', NULL, NULL, NULL, NULL, 1),
(12, 4, 'ROBIN ', '', 'AGUIRRE', 'USA', 'USA', '', 'USA', '9999999993', 'robinaguirre@gmail.com', '$2a$08$AoBa5Zpz/x.odxrRlDJB3.oZ5t.WQImY5wx1kMLvBa8d1CWp6j/le', '2022-07-20 15:31:39', NULL, NULL, NULL, NULL, 1);

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
-- Indexes for table `trainer_awards`
--
ALTER TABLE `trainer_awards`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `course_content`
--
ALTER TABLE `course_content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `course_resources`
--
ALTER TABLE `course_resources`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

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
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `trainer_academic`
--
ALTER TABLE `trainer_academic`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `trainer_awards`
--
ALTER TABLE `trainer_awards`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `trainer_calibrations`
--
ALTER TABLE `trainer_calibrations`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=631;

--
-- AUTO_INCREMENT for table `trainer_exp`
--
ALTER TABLE `trainer_exp`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `trainer_services`
--
ALTER TABLE `trainer_services`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
