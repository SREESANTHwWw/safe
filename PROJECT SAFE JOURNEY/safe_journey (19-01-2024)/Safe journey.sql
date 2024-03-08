/*
SQLyog Community v13.1.5  (64 bit)
MySQL - 5.7.36 : Database - safe_journey
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`safe_journey` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `safe_journey`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add bus',7,'add_bus'),
(26,'Can change bus',7,'change_bus'),
(27,'Can delete bus',7,'delete_bus'),
(28,'Can view bus',7,'view_bus'),
(29,'Can add login',8,'add_login'),
(30,'Can change login',8,'change_login'),
(31,'Can delete login',8,'delete_login'),
(32,'Can view login',8,'view_login'),
(33,'Can add student',9,'add_student'),
(34,'Can change student',9,'change_student'),
(35,'Can delete student',9,'delete_student'),
(36,'Can view student',9,'view_student'),
(37,'Can add student_allocation',10,'add_student_allocation'),
(38,'Can change student_allocation',10,'change_student_allocation'),
(39,'Can delete student_allocation',10,'delete_student_allocation'),
(40,'Can view student_allocation',10,'view_student_allocation'),
(41,'Can add track',11,'add_track'),
(42,'Can change track',11,'change_track'),
(43,'Can delete track',11,'delete_track'),
(44,'Can view track',11,'view_track'),
(45,'Can add payment_notification',12,'add_payment_notification'),
(46,'Can change payment_notification',12,'change_payment_notification'),
(47,'Can delete payment_notification',12,'delete_payment_notification'),
(48,'Can view payment_notification',12,'view_payment_notification'),
(49,'Can add message',13,'add_message'),
(50,'Can change message',13,'change_message'),
(51,'Can delete message',13,'delete_message'),
(52,'Can view message',13,'view_message'),
(53,'Can add driver',14,'add_driver'),
(54,'Can change driver',14,'change_driver'),
(55,'Can delete driver',14,'delete_driver'),
(56,'Can view driver',14,'view_driver'),
(57,'Can add complaint',15,'add_complaint'),
(58,'Can change complaint',15,'change_complaint'),
(59,'Can delete complaint',15,'delete_complaint'),
(60,'Can view complaint',15,'view_complaint'),
(61,'Can add checking_report',16,'add_checking_report'),
(62,'Can change checking_report',16,'change_checking_report'),
(63,'Can delete checking_report',16,'delete_checking_report'),
(64,'Can view checking_report',16,'view_checking_report');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `auth_user` */

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(2,'auth','permission'),
(3,'auth','group'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(6,'sessions','session'),
(7,'myapp','bus'),
(8,'myapp','login'),
(9,'myapp','student'),
(10,'myapp','student_allocation'),
(11,'myapp','track'),
(12,'myapp','payment_notification'),
(13,'myapp','message'),
(14,'myapp','driver'),
(15,'myapp','complaint'),
(16,'myapp','checking_report');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2023-10-14 03:57:32.429877'),
(2,'auth','0001_initial','2023-10-14 03:57:32.651735'),
(3,'admin','0001_initial','2023-10-14 03:57:32.709335'),
(4,'admin','0002_logentry_remove_auto_add','2023-10-14 03:57:32.716280'),
(5,'admin','0003_logentry_add_action_flag_choices','2023-10-14 03:57:32.722379'),
(6,'contenttypes','0002_remove_content_type_name','2023-10-14 03:57:32.751509'),
(7,'auth','0002_alter_permission_name_max_length','2023-10-14 03:57:32.769916'),
(8,'auth','0003_alter_user_email_max_length','2023-10-14 03:57:32.785685'),
(9,'auth','0004_alter_user_username_opts','2023-10-14 03:57:32.793690'),
(10,'auth','0005_alter_user_last_login_null','2023-10-14 03:57:32.809699'),
(11,'auth','0006_require_contenttypes_0002','2023-10-14 03:57:32.812698'),
(12,'auth','0007_alter_validators_add_error_messages','2023-10-14 03:57:32.818785'),
(13,'auth','0008_alter_user_username_max_length','2023-10-14 03:57:32.835776'),
(14,'auth','0009_alter_user_last_name_max_length','2023-10-14 03:57:32.851829'),
(15,'auth','0010_alter_group_name_max_length','2023-10-14 03:57:32.869283'),
(16,'auth','0011_update_proxy_permissions','2023-10-14 03:57:32.876285'),
(17,'auth','0012_alter_user_first_name_max_length','2023-10-14 03:57:32.892976'),
(18,'myapp','0001_initial','2023-10-14 03:57:33.162645'),
(19,'sessions','0001_initial','2023-10-14 03:57:33.177680'),
(20,'myapp','0002_alter_driver_photo','2023-10-14 05:06:27.051402'),
(21,'myapp','0003_alter_driver_photo','2023-10-14 05:14:06.778155'),
(22,'myapp','0004_remove_payment_notification_student','2023-10-28 04:17:00.138023'),
(23,'myapp','0005_alter_complaint_date','2023-11-06 04:40:30.418534'),
(24,'myapp','0006_rename_engine_number_bus_chasis_number','2023-11-25 04:23:20.886093'),
(25,'myapp','0007_checking_report','2024-01-04 04:17:36.531957'),
(26,'myapp','0008_student_fee','2024-01-09 04:33:22.436348'),
(27,'myapp','0009_auto_20240109_1014','2024-01-09 04:44:33.530546'),
(28,'myapp','0010_payment_notification_year','2024-01-09 05:32:30.654677'),
(29,'myapp','0011_alter_student_fee','2024-01-12 05:33:08.750370'),
(30,'myapp','0012_auto_20240116_1001','2024-01-16 04:31:41.779700'),
(31,'myapp','0013_auto_20240119_1522','2024-01-19 09:52:50.554994');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('a36b90be8mfql62i0f6emvnbmeey0vsk','eyJsaWQiOiIifQ:1rB5XW:Kn6bouuy1ZiGIi75DJi-g5wfYSbh8HRBD9FzsWMub4M','2023-12-21 03:59:06.020457'),
('cn2yjtryr1fia3j17n2yo5n6jtnmm116','eyJsaWQiOiIifQ:1rB6CG:ADjDfjsAS5e976aLELC3R9WfsUSYi0jPLPiycYQFN5I','2023-12-21 04:41:12.429839'),
('v697eysezf7hz3fwb45v15rwxrs0t1sk','eyJsb2ciOiJsaW4ifQ:1rN9xl:9nt1r5qgsCNEuPoSnvSSajMD1cFf06V50-GpE1m7baU','2024-01-23 11:08:05.161184'),
('az4puyvqe86qs6ztwsbartw2r6alonws','eyJsb2ciOiIifQ:1rQkl4:tMeCm-_z1kts0hbTWaRVFfT-9PpIFnMLF8NZr5yVCS0','2024-02-02 09:01:50.418911'),
('264j8hwrbclpz07g996c9sedvfmjeeor','eyJsb2ciOiJsaW4ifQ:1rO9zv:ajgW9MsggO0w7tl_JDrmLCg1vEg8GHMhSnkKcQOUtzc','2024-01-26 05:22:27.612901'),
('wivw21qhcy4861ohy73epzsdcttm4mco','eyJsb2ciOiJsaW4ifQ:1rOFTA:82I9DGRT6czMbQX-3Ee5RdmAMyvWNch1GM5YUAdjuf0','2024-01-26 11:13:00.090555'),
('k54zkofnjevsqwxp7htga9u5fhhpye0i','eyJsb2ciOiJsaW4ifQ:1rPatV:Z8_pQRIyWU3B3Ye4eF-fQ1Jav7rl-Cau_ZnenL8Uecw','2024-01-30 04:17:45.591460');

/*Table structure for table `myapp_bus` */

DROP TABLE IF EXISTS `myapp_bus`;

CREATE TABLE `myapp_bus` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Bus_number` varchar(200) NOT NULL,
  `Bus_type` varchar(200) NOT NULL,
  `Total_seat` varchar(200) NOT NULL,
  `Photo` varchar(200) NOT NULL,
  `Chasis_number` varchar(200) NOT NULL,
  `DRIVER_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_bus_DRIVER_id_1a5e5bcf` (`DRIVER_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

/*Data for the table `myapp_bus` */

insert  into `myapp_bus`(`id`,`Bus_number`,`Bus_type`,`Total_seat`,`Photo`,`Chasis_number`,`DRIVER_id`) values 
(15,'09','BUS','16','/media/240119-112429.jpg','6788',15),
(13,'7','BUS','77','/media/240112-144938.jpg','09876545678',13);

/*Table structure for table `myapp_checking_report` */

DROP TABLE IF EXISTS `myapp_checking_report`;

CREATE TABLE `myapp_checking_report` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `status` varchar(200) NOT NULL,
  `checkin_time` varchar(200) NOT NULL,
  `checkout_time` varchar(200) NOT NULL,
  `Date` varchar(200) NOT NULL,
  `STUDENT_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_checking_report_STUDENT_id_84105fc3` (`STUDENT_id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

/*Data for the table `myapp_checking_report` */

insert  into `myapp_checking_report`(`id`,`status`,`checkin_time`,`checkout_time`,`Date`,`STUDENT_id`) values 
(25,'checkout','16:56:53','16:56:58','2024-01-19',6),
(24,'checkout','16:55:23','16:55:29','2024-01-19',13);

/*Table structure for table `myapp_complaint` */

DROP TABLE IF EXISTS `myapp_complaint`;

CREATE TABLE `myapp_complaint` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Complaint` varchar(600) NOT NULL,
  `Reply` varchar(600) NOT NULL,
  `Status` varchar(200) NOT NULL,
  `STUDENT_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_complaint_STUDENT_id_06b7b3d6` (`STUDENT_id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

/*Data for the table `myapp_complaint` */

insert  into `myapp_complaint`(`id`,`Date`,`Complaint`,`Reply`,`Status`,`STUDENT_id`) values 
(3,'2024-01-04','haaaaa','ok','replied',13),
(1,'2024-01-24','time delay','your request will be acepted soon','replied',3),
(4,'2024-01-04','haaaaa','ok will check have an nice day your request will be acepted soonyour request will be acepted soonyour request will be acepted soonyour request will be acepted soonyour request will be acepted soonyour request will be acepted soon','replied',13),
(5,'2024-01-04','haaaaa','pending','pending',13),
(6,'2024-01-04','haaaaa','pending','pending',13),
(7,'2024-01-04','haaaaa','pending','pending',13),
(8,'2024-01-04','haaaaa','pending','pending',13),
(9,'2024-01-04','haaaaa','pending','pending',13),
(10,'2024-01-04','haaaaa','pending','pending',13),
(11,'2024-01-04','haaaaa','pending','pending',13),
(12,'2024-01-04','haaaaa','pending','pending',13),
(13,'2024-01-04','haaaaa','pending','pending',13),
(14,'2024-01-04','haaaaa','pending','pending',13),
(15,'2024-01-04','hooo','pending','pending',13),
(16,'2024-01-04','aaaaa','scscdd','replied',13),
(17,'2024-01-09','fyuii','okda okke paranja pole','replied',13),
(18,'2024-01-09','rt','pending','pending',13),
(19,'2024-01-19','service bad','pending','pending',13),
(20,'2024-01-19','','pending','pending',13),
(21,'2024-01-19','hxhxcjf','pending','pending',13);

/*Table structure for table `myapp_driver` */

DROP TABLE IF EXISTS `myapp_driver`;

CREATE TABLE `myapp_driver` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) NOT NULL,
  `Place` varchar(200) NOT NULL,
  `Post` varchar(200) NOT NULL,
  `Pin` varchar(200) NOT NULL,
  `House_name` varchar(200) NOT NULL,
  `Phone_number` varchar(200) NOT NULL,
  `E_mail` varchar(200) NOT NULL,
  `Experience` varchar(200) NOT NULL,
  `Licence_number` varchar(200) NOT NULL,
  `photo` varchar(350) NOT NULL,
  `DOB` date NOT NULL,
  `Gender` varchar(100) NOT NULL,
  `LOGIN_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_driver_LOGIN_id_d631c337` (`LOGIN_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;

/*Data for the table `myapp_driver` */

insert  into `myapp_driver`(`id`,`Name`,`Place`,`Post`,`Pin`,`House_name`,`Phone_number`,`E_mail`,`Experience`,`Licence_number`,`photo`,`DOB`,`Gender`,`LOGIN_id`) values 
(15,'salih m k','mudikkode','pandallur','675544','madari karuvarathodi','9061550398','salihmadari12@gmail.com','4','778899876','/media/20240119-112017.jpg','2003-09-22','MALE',24),
(16,'salih m k','gvvrvgrg','tgygg','767575','madari karuvarathodi','9061550398','salihmadari12@gmail.com','55','67y7y77777h','/media/20240119-140808.jpg','2024-01-03','FEMALE',27),
(9,'bayis','karuvara','kkun','55892','akarapambil','6578945674','bayisbasu@gmail.com','5','kl10245678345','/media/20231125-095733.jpg','1990-06-05','MALE',11),
(6,'nawaz','kollam','kozhikode','675432','vilakkumadathil','90797234','nawaztr@gmail.com','10','3568926552','/media/20231021-102739.jpg','2023-10-18','MALE',8),
(14,'Amals','anakayam','irumbuzhi','435367','chakakuru house','68865938','amal@gmail.com','4','KL435672819','/media/20240112-111435.jpg','2024-01-09','FEMALE',21),
(13,'Ronaldo','portugal','Lisbon','8765','vaidhyarpadi house','9946543122','cr7@gmail.com','2','76898544','/media/20240101-092207.jpg','1997-02-05','MALE',15);

/*Table structure for table `myapp_login` */

DROP TABLE IF EXISTS `myapp_login`;

CREATE TABLE `myapp_login` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(200) NOT NULL,
  `password` varchar(200) NOT NULL,
  `type` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

/*Data for the table `myapp_login` */

insert  into `myapp_login`(`id`,`username`,`password`,`type`) values 
(1,'admin@gmail.com','safejourney','admin'),
(2,'cs21.1420@ekc.edu.in','8510','driver'),
(6,'sallubhai@gmail.com','1877','driver'),
(7,'aj7@gmail.com','safejourney','admin'),
(8,'nawaztr@gmail.com','3185','driver'),
(11,'bayisbasu@gmail.com','6594','driver'),
(15,'cr7@gmail.com','12345','driver'),
(16,'waseem12@gmail.com','1234','parent'),
(27,'salihmadari12@gmail.com','8788','driver'),
(26,'manoj@gmail.com','6576878777','parent'),
(25,'manoj@gmail.com','8136832747','parent'),
(24,'salihmadari12@gmail.com','4363','driver'),
(23,'shamilsalu@gmail.com','9999','parent');

/*Table structure for table `myapp_message` */

DROP TABLE IF EXISTS `myapp_message`;

CREATE TABLE `myapp_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Message` varchar(200) NOT NULL,
  `Type` varchar(200) NOT NULL,
  `Date` varchar(200) NOT NULL,
  `LOGIN_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_message_LOGIN_id_efbe4216` (`LOGIN_id`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;

/*Data for the table `myapp_message` */

insert  into `myapp_message`(`id`,`Message`,`Type`,`Date`,`LOGIN_id`) values 
(54,'jhfddff','admin','2024-01-19',24),
(53,'hhfddd','admin','2024-01-19',24),
(52,'yggcdgg','admin','2024-01-19',24),
(51,'yeah dhak','driver','2024-01-19',24),
(50,'jfcv','driver','2024-01-19',24),
(49,'how r u','driver','2024-01-19',24),
(48,'hai','driver','2024-01-19',24),
(47,'Traffic jam','driver','2024-01-19',24),
(46,'hhhhhhfff','driver','2024-01-19',15),
(45,'shamil evide','driver','2024-01-19',24),
(44,'jjjji','driver','2024-01-19',15),
(43,'eeee','driver','2024-01-19',15),
(42,'Break down','driver','2024-01-19',15),
(41,'kkkkktg5c4yg6hy','admin','2024-01-22',15),
(40,'iiiii','driver','2024-01-19',15),
(39,'hellooooooo','driver','2024-01-19',15),
(38,'gaaaa','driver','2024-01-19',15),
(37,'haaaa','driver','2024-01-19',11),
(36,'hello','driver','2024-01-19',15);

/*Table structure for table `myapp_payment_notification` */

DROP TABLE IF EXISTS `myapp_payment_notification`;

CREATE TABLE `myapp_payment_notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Month` varchar(200) NOT NULL,
  `Fee` varchar(200) NOT NULL,
  `Last_date` varchar(200) NOT NULL,
  `Status` varchar(200) NOT NULL,
  `STUDENT_id` bigint(20) NOT NULL,
  `Year` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_payment_notification_STUDENT_id_0b9c4b2b` (`STUDENT_id`)
) ENGINE=MyISAM AUTO_INCREMENT=116 DEFAULT CHARSET=latin1;

/*Data for the table `myapp_payment_notification` */

insert  into `myapp_payment_notification`(`id`,`Month`,`Fee`,`Last_date`,`Status`,`STUDENT_id`,`Year`) values 
(110,'1','','2024-01-19','pending',12,'2024'),
(109,'1','','2024-01-19','Done',13,'2024'),
(108,'1','','2024-01-19','pending',10,'2024'),
(107,'1','','2024-01-19','pending',9,'2024'),
(106,'1','','2024-01-19','pending',8,'2024'),
(105,'1','','2024-01-19','pending',5,'2024'),
(104,'1','','2024-01-19','pending',6,'2024'),
(103,'1','','2024-01-19','pending',3,'2024'),
(102,'1','','2024-01-19','pending',7,'2024'),
(101,'1','','2024-01-26','',15,'2024'),
(100,'1','','2024-01-26','pending',14,'2024'),
(99,'1','','2024-01-26','pending',12,'2024'),
(98,'1','','2024-01-26','Done',13,'2024'),
(97,'1','','2024-01-26','pending',10,'2024'),
(96,'1','','2024-01-26','pending',9,'2024'),
(95,'1','','2024-01-26','pending',8,'2024'),
(94,'1','','2024-01-26','pending',5,'2024'),
(91,'1','','2024-01-26','pending',7,'2024'),
(92,'1','','2024-01-26','pending',3,'2024'),
(93,'1','','2024-01-26','pending',6,'2024'),
(90,'1','','2024-03-20','pending',15,'2024'),
(89,'1','','2024-03-20','pending',14,'2024'),
(88,'1','','2024-03-20','pending',12,'2024'),
(87,'1','','2024-03-20','pending',13,'2024'),
(86,'1','','2024-03-20','pending',10,'2024'),
(85,'1','','2024-03-20','pending',9,'2024'),
(84,'1','','2024-03-20','pending',8,'2024'),
(83,'1','','2024-03-20','pending',5,'2024'),
(82,'1','','2024-03-20','pending',6,'2024'),
(81,'1','','2024-03-20','pending',3,'2024'),
(80,'1','','2024-03-20','pending',7,'2024'),
(111,'1','','2024-01-19','pending',14,'2024'),
(112,'1','','2024-01-19','pending',15,'2024'),
(113,'1','','2024-01-19','pending',16,'2024'),
(114,'1','','2024-01-19','pending',17,'2024'),
(115,'1','','2024-01-19','pending',18,'2024');

/*Table structure for table `myapp_student` */

DROP TABLE IF EXISTS `myapp_student`;

CREATE TABLE `myapp_student` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(200) NOT NULL,
  `Place` varchar(200) NOT NULL,
  `Post` varchar(200) NOT NULL,
  `Pin` varchar(200) NOT NULL,
  `House_name` varchar(200) NOT NULL,
  `Parent_name` varchar(200) NOT NULL,
  `Parent_number` varchar(200) NOT NULL,
  `Register_number` varchar(200) NOT NULL,
  `Gender` varchar(200) NOT NULL,
  `Phone_number` varchar(200) NOT NULL,
  `E_mail` varchar(200) NOT NULL,
  `LOGIN_id` bigint(20) NOT NULL,
  `Fee` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_student_LOGIN_id_d3327a2f` (`LOGIN_id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Data for the table `myapp_student` */

insert  into `myapp_student`(`id`,`Name`,`Place`,`Post`,`Pin`,`House_name`,`Parent_name`,`Parent_number`,`Register_number`,`Gender`,`Phone_number`,`E_mail`,`LOGIN_id`,`Fee`) values 
(7,'sukooor','cholakund','parapur','676555','mangalasheri','siraj','89898777736','shjgfj','MALE','702716747','sukoorsundaran@gmail.com',1,'1000'),
(3,'shibin','flutter','rewss','9879879','ddwssaaaa','raju bhai','45262624999','100069D71jecjgr','FEMALE','0988575342','shibinbhai@gmail.com',1,'1550'),
(6,'sulaiman','vettekode','arapra','67834','thatttamparambil','koshi','678491011','4500415699CB','MALE','9645345267','sulaiman12@gmail.com',1,'1450'),
(5,'vignesh','manjeri','kottakkal','676543','paramashivan','father','9867542321','564321','FEMALE','989756432','sukoorvig@gmail.com',1,'1800'),
(8,'soorabi','kochi','edavana','776656','girapunjij','asarpp','5635888893','0099','FEMALE','8349263383','soorabi09@gmail.com',1,'1350'),
(9,'azik','kochi','edavana','776656','girapunjij','asarpp','5635888893','0099','MALE','8349263383','soorabi09@gmail.com',1,'1200'),
(10,'sinan d','gsdnaqdg','hjfjmyfr','561365320','ngsfd','hcf','163217344','62331','MALE','13785128125','qdw@gmail.com',1,'1987'),
(13,'waseem','manjeri','anakkayam','676522','madari house','shajahan','8876452311','100069D71BB5','MALE','8967231255','waseem12@gmail.com',16,'1789'),
(12,'aymu.ck','bubjb','ghbhjbhjn','45676','vilakkumadathil','ecrvtbyu','4567890','34567889','FEMALE','907979797969','aymu@gmail.com',1,'1345'),
(14,'azi','malappuram','karakunn','676522','madari house','shaju','88764527654','241112','MALE','8967231255','azihh@gmail.com',18,'1000'),
(15,'Anfah','Pilathara','Kadampuzha','675333','Kadayikkal','Anwar','43567289','4356','MALE','78906678','anfah@gmail.com',20,'9898'),
(16,'Shamil','pandallur','kadambod','889008','korambayil house','Hamza','9846557622','4532','MALE','9087675433','shamilsalu@gmail.com',23,'4000'),
(17,'manoj','kollkata','kaakanachi','626262','soomba house','ragerji bhai','8136832747','112237','MALE','7523253873','manoj@gmail.com',25,'7899'),
(18,'manoj','kollkata','kaakanachi','626262','soomba house','ragerji bhai','6576878777','112237','MALE','7523253873','manoj@gmail.com',26,'7899');

/*Table structure for table `myapp_student_allocation` */

DROP TABLE IF EXISTS `myapp_student_allocation`;

CREATE TABLE `myapp_student_allocation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Status` varchar(200) NOT NULL,
  `BUS_id` bigint(20) NOT NULL,
  `STUDENT_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_student_allocation_BUS_id_973766eb` (`BUS_id`),
  KEY `myapp_student_allocation_STUDENT_id_a34adee4` (`STUDENT_id`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

/*Data for the table `myapp_student_allocation` */

insert  into `myapp_student_allocation`(`id`,`Status`,`BUS_id`,`STUDENT_id`) values 
(37,'allocated',13,16),
(38,'allocated',15,7),
(34,'allocated',13,13);

/*Table structure for table `myapp_track` */

DROP TABLE IF EXISTS `myapp_track`;

CREATE TABLE `myapp_track` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Date` varchar(200) NOT NULL,
  `Longitude` varchar(200) NOT NULL,
  `BUS_id` bigint(20) NOT NULL,
  `Latitude` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_track_BUS_id_07eb2a90` (`BUS_id`)
) ENGINE=MyISAM AUTO_INCREMENT=311 DEFAULT CHARSET=latin1;

/*Data for the table `myapp_track` */

insert  into `myapp_track`(`id`,`Date`,`Longitude`,`BUS_id`,`Latitude`) values 
(310,'2024-01-19','75.783966',15,'11.2589337'),
(309,'2024-01-19','75.7839657',15,'11.2589342'),
(308,'2024-01-19','75.7839631',15,'11.2589516'),
(307,'2024-01-19','75.7839631',15,'11.2589516'),
(306,'2024-01-19','75.7839631',15,'11.2589516'),
(305,'2024-01-19','75.7839631',15,'11.2589516'),
(304,'2024-01-19','75.7839631',15,'11.2589516'),
(303,'2024-01-19','75.7839631',15,'11.2589516'),
(302,'2024-01-19','75.7839631',15,'11.2589516'),
(301,'2024-01-19','75.7839631',15,'11.2589516'),
(300,'2024-01-19','75.7839631',15,'11.2589516'),
(299,'2024-01-19','75.7839631',15,'11.2589516'),
(298,'2024-01-19','75.7839631',15,'11.2589516'),
(297,'2024-01-19','75.7839631',15,'11.2589516'),
(296,'2024-01-19','75.7839631',15,'11.2589516'),
(295,'2024-01-19','75.7839631',15,'11.2589516'),
(294,'2024-01-19','75.7839631',15,'11.2589516'),
(293,'2024-01-19','75.7839631',15,'11.2589516'),
(292,'2024-01-19','75.7839631',15,'11.2589516'),
(291,'2024-01-19','75.7839643',15,'11.2589442'),
(290,'2024-01-19','75.7839638',15,'11.2589409'),
(289,'2024-01-19','75.7839638',15,'11.2589409'),
(288,'2024-01-19','75.7839638',15,'11.2589409'),
(287,'2024-01-19','75.7839638',15,'11.2589409'),
(286,'2024-01-19','75.7839633',15,'11.258933'),
(285,'2024-01-19','75.7839633',15,'11.258933'),
(284,'2024-01-19','75.7839636',15,'11.2589331'),
(283,'2024-01-19','75.7839636',15,'11.2589331'),
(282,'2024-01-19','75.7839636',15,'11.2589331'),
(281,'2024-01-19','75.7839636',15,'11.2589331'),
(280,'2024-01-19','75.7839636',15,'11.2589331'),
(279,'2024-01-19','75.7839636',15,'11.2589331'),
(278,'2024-01-19','75.7839636',15,'11.2589331'),
(277,'2024-01-19','75.7839636',15,'11.2589331'),
(276,'2024-01-19','75.7839636',15,'11.2589331'),
(275,'2024-01-19','75.7839636',15,'11.2589331'),
(274,'2024-01-19','75.7839636',15,'11.2589331'),
(273,'2024-01-19','75.7839636',15,'11.2589331'),
(272,'2024-01-19','75.7839636',15,'11.2589333'),
(271,'2024-01-19','75.7839636',15,'11.2589333'),
(270,'2024-01-19','75.7839636',15,'11.2589333'),
(269,'2024-01-19','75.7839636',15,'11.2589333'),
(268,'2024-01-19','75.7839636',15,'11.2589333'),
(267,'2024-01-19','75.7839636',15,'11.2589333'),
(266,'2024-01-19','75.7839636',15,'11.2589333'),
(265,'2024-01-19','75.7839636',15,'11.2589333'),
(264,'2024-01-19','75.7839636',15,'11.2589333'),
(263,'2024-01-19','75.7839635',15,'11.2589334'),
(262,'2024-01-19','75.7839061',15,'11.2589282'),
(261,'2024-01-19','75.7839061',15,'11.2589282'),
(260,'2024-01-19','75.7839061',15,'11.2589282'),
(259,'2024-01-19','75.783843',15,'11.258915'),
(258,'2024-01-19','75.783843',15,'11.258915'),
(257,'2024-01-19','75.783843',15,'11.258915'),
(256,'2024-01-19','75.783843',15,'11.258915'),
(255,'2024-01-19','75.783843',15,'11.258915'),
(254,'2024-01-19','75.783843',15,'11.258915'),
(253,'2024-01-19','75.783843',15,'11.258915'),
(252,'2024-01-19','75.783843',15,'11.258915'),
(251,'2024-01-19','75.783843',15,'11.258915'),
(250,'2024-01-19','75.783843',15,'11.258915'),
(249,'2024-01-19','75.7838117',15,'11.2589139'),
(248,'2024-01-19','75.7838116',15,'11.2589325'),
(247,'2024-01-19','75.783805',15,'11.2589033'),
(246,'2024-01-19','75.7839626',15,'11.2588213'),
(245,'2024-01-19','75.7839665',15,'11.2588028'),
(244,'2024-01-19','75.7839898',15,'11.2587575'),
(243,'2024-01-19','75.7840498',15,'11.2587441'),
(242,'2024-01-19','75.7841448',15,'11.258697'),
(241,'2024-01-19','75.7841297',15,'11.2587831'),
(240,'2024-01-19','75.7841748',15,'11.258872'),
(239,'2024-01-19','75.7839626',15,'11.2589503'),
(238,'2024-01-19','75.7839626',15,'11.2589503'),
(237,'2024-01-19','75.7839626',15,'11.2589503'),
(236,'2024-01-19','75.7839626',15,'11.2589503'),
(235,'2024-01-19','75.7839626',15,'11.2589503'),
(234,'2024-01-19','75.7839626',15,'11.2589503'),
(229,'2024-01-19','75.7839646',15,'11.2589461'),
(230,'2024-01-19','75.7839646',15,'11.2589461'),
(231,'2024-01-19','75.7839626',15,'11.2589503'),
(232,'2024-01-19','75.7839626',15,'11.2589503'),
(233,'2024-01-19','75.7839626',15,'11.2589503');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
