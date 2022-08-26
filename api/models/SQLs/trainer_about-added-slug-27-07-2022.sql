-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 27, 2022 at 09:38 AM
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
-- Table structure for table `trainer_about`
--

CREATE TABLE `trainer_about` (
  `id` bigint(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `middlename` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) NOT NULL,
  `slug` varchar(200) NOT NULL,
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

INSERT INTO `trainer_about` (`id`, `user_id`, `firstname`, `middlename`, `lastname`, `slug`, `biography`, `base_image`, `trainings`, `profile_image`, `award_image`, `created_at`) VALUES
(1, 1, 'Rajesh', '', 'Singh', 'rajesh-singh-1', '<h3>Biography</h3>\r\n<p>But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. </p>', 'base_1_base-rajesh.png', '<div class=\"awadText slideInUp wow \">\r\n<p class=\"boldText\">Training Name Duration Start -/ End date Location</p>\r\n<p>Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \">\r\n<p class=\"boldText\">Training Name Duration Start -/ End date Location</p>\r\n<p>Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \">\r\n<p class=\"boldText\">Training Name Duration Start -/ End date Location</p>\r\n<p>Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \">\r\n<p class=\"boldText\">Training Name Duration Start -/ End date Location</p>\r\n<p>Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<p>&nbsp;</p>', 'profile_1_Bauman (1).jpg', 'award_1_bannerProfile.jpg', '2022-07-08 09:34:29'),
(2, 2, 'NOORHIMLI (HIMLI) ', '', 'ALI', 'noorhimli-himli-ali-2', '<p>With 20+ years of leadership experience in global training delivery, training management, regional sales and services management in the telecommunication, contact centre and consultancy industries, Himli offers proven track record and expertise in the Asia Pacific region. His career has spanned across several successful US multinational companies including IBM Germany, AT&amp;T, Lucent Technologies, Avaya Inc, Aspect Software Inc, COPC Inc, Sumaria Networks LLC (US), Minaya Learning LLC (US), The Training Associates Corp (US), Imparta (UK), PD Training (Australia) and technology/ training start-up companies in Singapore. He has held several senior sales and management positions in the region including being a co-founder of a technology startup company.</p>', 'base_2_noor.png', '<p><strong>Training that Himli had delivered:</strong></p>\r\n<ol>\r\n<li>John C. Maxwell Leadership Training</li>\r\n<ol>\r\n<li>The 21 Irrefutable Laws of Leadership</li>\r\n</ol>\r\n</ol>\r\n<ol>\r\n<li>Leadership &amp; You</li>\r\n<li>Leadership &amp; Them</li>\r\n</ol>\r\n<ul>\r\n<li>Leadership &amp; Environment</li>\r\n</ul>\r\n<ol>\r\n<ol>\r\n<li>Leadership Gold</li>\r\n<li>15 Invaluable Laws of Growth</li>\r\n<li>Everyone Communicates, Few Connect</li>\r\n</ol>\r\n<li>TetraMap Behaviour Profiling Training &ndash; Earth/Air/Water/Fire</li>\r\n<li>Channel Management Training</li>\r\n<li>Presentation Skills Training &ndash; Virtual and Face-to-Face</li>\r\n<li><strong>HP Contractual Selling Training</strong></li>\r\n<li>Motivational Training</li>\r\n<li>Motivational Coaching &amp; Mentoring Programs</li>\r\n<li>Doon Innovation Methodologies</li>\r\n<li><strong>Value Selling and Creating Client Value Programs</strong></li>\r\n<li><strong>Coaching for Impact Sales Manager Programs</strong></li>\r\n<li>Leadership, Management &amp; Employee related Microsoft Global Programs</li>\r\n</ol>\r\n<p>&nbsp;</p>', 'profile_2_bg_7.jpg', 'award_2_bannerProfile.jpg', '2022-07-11 15:17:33'),
(3, 4, 'Ben', '', 'Jacobs', 'ben-jascobs-3', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Being robust &amp; feature pack CMS, Magento is serving tons of options as a part of the community edition to fulfill the needs of a store owner. Products and services sold within the store are assets and identity of the organization. Selling these stuff online, the product images, videos, docs and descriptions that are given on product page is helpful for the store owner to sell their product</span></p>', 'base_3_trainer2.png', '<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Training Name Duration Start -/ End date Location</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Training Name Duration Start -/ End date Location</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Training Name Duration Start -/ End date Location</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Training Name Duration Start -/ End date Location</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Nis volut errovidem quam haris nisinve rempor ad modi volore nam nonsed molut velent, sequis ma in estintiatint velest adi od magnimi litaepr eicidus simodipis.</p>\r\n</div>', 'profile_3_trainer2.jpg', 'award_3_bannerProfile.jpg', '2022-07-20 10:53:05'),
(4, 6, 'James', '', ' ', 'james-4', '<p><strong style=\"box-sizing: border-box; color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\"> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</span></p>', 'base_4_trainer2.png', 'null', 'profile_4_trainer2_2.jpg', 'award_4_bannerProfile.jpg', '2022-07-20 11:48:41'),
(5, 7, 'Jon', '', 'Hung', 'jon-hung-5', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Being robust &amp; feature pack CMS, Magento is serving tons of options as a part of the community edition to fulfill the needs of a store owner. Products and services sold within the store are assets and identity of the organization. Selling these stuff online, the product images, videos, docs and descriptions that are given on product page is helpful for the store owner to sell their product</span></p>', 'base_5_trainer3.png', '<p><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary</span></p>', 'profile_5_trainer3.jpg', 'award_5_bannerProfile.jpg', '2022-07-20 12:20:25'),
(6, 8, 'Jose', '', 'Alexandro', 'jose-alexandro-6', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Being robust &amp; feature pack CMS, Magento is serving tons of options as a part of the community edition to fulfill the needs of a store owner. Products and services sold within the store are assets and identity of the organization. Selling these stuff online, the product images, videos, docs and descriptions that are given on product page is helpful for the store owner to sell their product</span></p>', 'base_6_trainer4.png', '<p><strong style=\"margin: 0px; padding: 0px; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</span></p>', 'profile_6_trainer4.jpg', 'award_6_bannerProfile.jpg', '2022-07-20 12:48:59'),
(7, 9, 'Manish', '', '  Gupta', 'manish-gupta-7', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful.</span></p>', 'base_7_trainer2.png', '<p><strong style=\"margin: 0px; padding: 0px; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">Lorem Ipsum</strong><span style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; text-align: justify; background-color: #ffffff;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</span></p>', 'profile_7_trainer2_2.jpg', 'award_7_bannerProfile.jpg', '2022-07-20 13:24:21'),
(8, 10, 'Marciano ', ' Soto', 'Pavon', 'soto-pavon-8', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Share my professional experience in design, implementation, maintenance and training in Business Communications Networks and in a Call Center environment.</span></p>', 'base_8_marciano-profile_1.png', '<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Free Lance Instructor January 2016&nbsp;-/ April 2019</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Deliver Avaya training on site and virtual. Training developer for Avaya team engagement solutions</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">ACSS-7290 Avaya Enterprise Team Engagement Solution certification. AIPS IP Office</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">AVAYA Communications de M&eacute;xico, S.A December 2012 -/ December 2015</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">As a training manager I managed to increase enrollment to courses and consequently billing by 75%</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">As an instructor I got the certifications in three technologies, Avaya Aura Contact Center, AES and IP Telephony</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Huawei January 2012-/ September 2012&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">VoIP Technical instructor. Develop a certification exam for Huawei Unified Communications that was applied to 5 Business Partners.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Participate as installation coordinator in an IP Telephony implementation for a government office where 5000 IP endpoints were installed</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Summaria Networks October 2010&nbsp;-/ December 2011&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Deliver Avaya training globally. Implementation Design and Sales curriculums</p>\r\n</div>', 'profile_8_bg_6.jpg', 'award_8_bannerProfile.jpg', '2022-07-20 13:55:49'),
(9, 11, 'Miguel ', '', 'Sarabia', 'miguel-sarabia-9', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">Miguel Sarabia is a soft skills trainer based in Budapest, Hungary since 2001. He specialises in negotiations skills, leadership techniques, sales and communications training. He applies his knowledge and experience in an extremely engaging and energetic way to help managers and line staff bring out the most of what they are capable of.</span></p>', 'base_9_miguel.png', '<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Manufacturing Industries 2001/ 2018 Hungary</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Interpersonal Communication Skills and Assertiveness training for managers at Budapest shared services centres of several multinationals</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Negotiations Skills 2005 - 2017, Boston</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Delivery of Negotiations Skills training in Europe on behalf of a Boston &ndash; based company</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">Banking Duration 2003 - 2020 Boston</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Banking Financial training - Bank Austria , West LB</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">hospitality industry 2007 - 2020 Boston</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Leadership training for Management of several five star hotels</p>\r\n</div>', 'profile_9_bg_5.jpg', 'award_9_bannerProfile.jpg', '2022-07-20 15:06:06'),
(10, 12, 'ROBIN ', '', 'AGUIRRE', 'robin-aguirre-10', '<p><span style=\"color: #a7a9ac; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">TRAINING &amp; DEVELOPMENT &ndash; COURSE / NETWORKING &amp; COMMUNICATIONS / MATERIAL DEVELOPMENT &ndash; ACCOUNT MANAGEMENT PRODUCT MARKETING &ndash; WRITING / COMMUNICATIONS &ndash; SOFTWARE DEVELOPMENT &ndash; SYSTEM INSTALLATION PRODUCT DEVELOPMENT &amp; LAUNCH &ndash; RESEARCH &amp; DEVELOPMENT &ndash; TEAM LEADERSHIP &ndash; CLIENT RELATIONS&nbsp;&nbsp;</span></p>', 'base_10_circle-cropped_1_.png', '<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">PRINCIPAL TECHNICAL TRAINER &ndash; GLOBAL KNOWLEDGE | 2004 - Present</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Provide training for three major product lines: Avaya, IBM, and Cisco lines of business; create and deliver courses that generate more than $35M in annual revenue for a $325M corporation.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Develop and lead Avaya Enterprise Solutions Training classes for customers and partners, delivering courses on-site, virtually, and at company training facilities nationwide; technical courses include software, hardware, configuration, administration, and maintenance of the Avaya product line.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">PRINCIPAL TECHNICAL ADVISER/COURSE DEVELOPER &ndash; GLOBAL KNOWLEDGE | 2000-2004</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Retained when Nortel sold its training group to Global Knowledge, serving as an instructor and course developer for multiple product lines.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Served as Technical Advisor and Course Developer for Nortel Enterprise Solutions, providing instructional courses for both internal and external Nortel customers.</p>\r\n</div>\r\n<div class=\"awadText slideInUp wow \" style=\"box-sizing: border-box; animation-name: slideInUp; margin-bottom: 30px; position: relative; padding-left: 0px; color: #4f5052; font-family: \'segoe UI\'; font-size: 14px; background-color: #ffffff;\">\r\n<p class=\"boldText\" style=\"box-sizing: border-box; margin: 0px 0px 10px; font-weight: bold;\">SENIOR TECHNICAL TRAINER/ARCHITECT &ndash; NORTEL NETWORKS | 1992-2000</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Served as hardware/software technical trainer and writer for Nortel Enterprise Solution Training.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Served as hardware/software technical trainer and writer for Nortel Enterprise Solution Training.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px;\">Recognized as a Subject Matter Expert for the Meridian 1 PBXs on various software releases</p>\r\n</div>', 'profile_10_robin_aguirre.jpg', 'award_10_bannerProfile.jpg', '2022-07-20 15:31:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `trainer_about`
--
ALTER TABLE `trainer_about`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `trainer_about`
--
ALTER TABLE `trainer_about`
  MODIFY `id` bigint(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
