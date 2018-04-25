UPDATE mysql.user SET password=PASSWORD('<%= p("mariadb.admin_user.password") %>') WHERE user='root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '<%= p("mariadb.admin_user.password") %>' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE USER 'keystone'@'localhost' IDENTIFIED BY 'swiftstack';
CREATE DATABASE IF NOT EXISTS keystone CHARACTER SET utf8 COLLATE utf8_general_ci;
use keystone;
GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' IDENTIFIED BY 'swiftstack' WITH GRANT OPTION;

/*
SQLyog Ultimate
MySQL - 10.1.22-MariaDB : Database - broker
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`broker` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `broker`;

/*Table structure for table `service_instance` */

DROP TABLE IF EXISTS `service_instance`;

CREATE TABLE `service_instance` (
  `service_instance_id` varchar(255) NOT NULL,
  `dashboard_url` varchar(255) DEFAULT NULL,
  `organization_guid` varchar(255) DEFAULT NULL,
  `plan_id` varchar(255) DEFAULT NULL,
  `service_id` varchar(255) DEFAULT NULL,
  `space_guid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`service_instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`delivery_pipeline` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `delivery_pipeline`;

/*Table structure for table `authority` */

DROP TABLE IF EXISTS `authority`;

CREATE TABLE `authority` (
  `id` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `auth_type` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `auth_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cf_info` */

DROP TABLE IF EXISTS `cf_info`;

CREATE TABLE `cf_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `service_instances_id` varchar(255) NOT NULL,
  `cf_name` varchar(255) NOT NULL,
  `cf_id` varchar(255) NOT NULL,
  `cf_password` varchar(255) NOT NULL,
  `cf_api_url` varchar(255) NOT NULL,
  `description` text,
  `user_id` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;

/*Table structure for table `cf_url` */

DROP TABLE IF EXISTS `cf_url`;

CREATE TABLE `cf_url` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `service_instances_id` varchar(255) NOT NULL,
  `cf_api_name` varchar(255) NOT NULL,
  `cf_api_url` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

/*Table structure for table `ci_info` */

DROP TABLE IF EXISTS `ci_info`;

CREATE TABLE `ci_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_url` varchar(255) DEFAULT NULL,
  `used_count` int(11) DEFAULT '0',
  `type` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT 'N',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Table structure for table `file_info` */

DROP TABLE IF EXISTS `file_info`;

CREATE TABLE `file_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `file_url` varchar(255) NOT NULL,
  `original_file_name` varchar(255) NOT NULL,
  `stored_file_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

/*Table structure for table `granted_authority` */

DROP TABLE IF EXISTS `granted_authority`;

CREATE TABLE `granted_authority` (
  `id` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `instance_use_id` bigint(20) DEFAULT NULL,
  `authority_id` varchar(255) NOT NULL,
  `auth_code` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKmnl3l55ouqd8cmxqy1h7fuxqg` (`authority_id`),
  KEY `FK288xuffrgdmthn0qduv15qenq` (`instance_use_id`),
  CONSTRAINT `FK288xuffrgdmthn0qduv15qenq` FOREIGN KEY (`instance_use_id`) REFERENCES `instance_use` (`id`),
  CONSTRAINT `FKmnl3l55ouqd8cmxqy1h7fuxqg` FOREIGN KEY (`authority_id`) REFERENCES `authority` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `instance_use` */

DROP TABLE IF EXISTS `instance_use`;

CREATE TABLE `instance_use` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `service_instances_id` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKhl9yxr1apo2gl15ptufmfwxm5` (`service_instances_id`),
  KEY `FK457b685l6r2p6yc2rvxrlpq3r` (`user_id`),
  CONSTRAINT `FK457b685l6r2p6yc2rvxrlpq3r` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKhl9yxr1apo2gl15ptufmfwxm5` FOREIGN KEY (`service_instances_id`) REFERENCES `service_instances` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=229 DEFAULT CHARSET=utf8;

/*Table structure for table `job` */

DROP TABLE IF EXISTS `job`;

CREATE TABLE `job` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `service_instances_id` varchar(255) NOT NULL,
  `pipeline_id` int(11) NOT NULL,
  `job_type` varchar(255) NOT NULL,
  `job_name` varchar(255) NOT NULL,
  `job_guid` varchar(255) NOT NULL,
  `group_order` int(11) NOT NULL,
  `job_order` int(11) NOT NULL,
  `builder_type` varchar(255) DEFAULT NULL,
  `build_job_id` int(11) DEFAULT NULL,
  `job_trigger` varchar(255) DEFAULT NULL,
  `post_action_yn` varchar(255) DEFAULT 'N',
  `repository_type` varchar(255) DEFAULT NULL,
  `repository_url` varchar(255) DEFAULT NULL,
  `repository_id` varchar(255) DEFAULT NULL,
  `repository_account_id` varchar(255) DEFAULT NULL,
  `repository_account_password` varchar(255) DEFAULT NULL,
  `repository_branch` varchar(255) DEFAULT NULL,
  `repository_commit_revision` varchar(255) DEFAULT NULL,
  `cf_info_id` bigint(20) DEFAULT NULL,
  `app_name` varchar(255) DEFAULT NULL,
  `app_url` varchar(255) DEFAULT NULL,
  `deploy_type` varchar(255) DEFAULT NULL,
  `blue_green_deploy_status` varchar(255) DEFAULT NULL,
  `deploy_target_org` varchar(255) DEFAULT NULL,
  `deploy_target_space` varchar(255) DEFAULT NULL,
  `manifest_use_yn` varchar(1) DEFAULT 'N',
  `manifest_script` text,
  `inspection_project_id` varchar(255) DEFAULT NULL,
  `inspection_project_name` varchar(255) DEFAULT NULL,
  `inspection_project_key` varchar(255) DEFAULT NULL,
  `inspection_profile_key` varchar(255) DEFAULT NULL,
  `inspection_gate_id` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8;

/*Table structure for table `job_history` */

DROP TABLE IF EXISTS `job_history`;

CREATE TABLE `job_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL,
  `previous_job_number` int(11) DEFAULT NULL,
  `job_number` int(11) NOT NULL,
  `duration` bigint(20) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `file_id` int(11) DEFAULT NULL,
  `trigger_type` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8;

/*Table structure for table `pipeline` */

DROP TABLE IF EXISTS `pipeline`;

CREATE TABLE `pipeline` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(255) NOT NULL,
  `service_instances_id` varchar(255) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `FKev6qocyrugsn8auxb6y29cjbt` (`service_instances_id`),
  CONSTRAINT `FKev6qocyrugsn8auxb6y29cjbt` FOREIGN KEY (`service_instances_id`) REFERENCES `service_instances` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Table structure for table `quality_gate` */

DROP TABLE IF EXISTS `quality_gate`;

CREATE TABLE `quality_gate` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `service_instances_id` varchar(255) NOT NULL,
  `quality_gate_id` bigint(20) NOT NULL,
  `quality_gate_name` varchar(255) NOT NULL,
  `gate_default_yn` varchar(1) NOT NULL DEFAULT 'N',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `quality_profile` */

DROP TABLE IF EXISTS `quality_profile`;

CREATE TABLE `quality_profile` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `service_instances_id` varchar(255) NOT NULL,
  `quality_profile_id` bigint(20) NOT NULL,
  `quality_profile_name` varchar(255) NOT NULL,
  `quality_profile_key` varchar(255) NOT NULL,
  `language` varchar(255) NOT NULL,
  `language_name` varchar(255) NOT NULL,
  `profile_default_yn` varchar(1) NOT NULL DEFAULT 'N',
  `active_rule_count` int(11) NOT NULL,
  `active_deprecated_rule_count` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `service_instances` */

DROP TABLE IF EXISTS `service_instances`;

CREATE TABLE `service_instances` (
  `id` varchar(255) NOT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `ci_server_url` varchar(255) DEFAULT 'http://115.68.46.29',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `sonar_project` */

DROP TABLE IF EXISTS `sonar_project`;

CREATE TABLE `sonar_project` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `service_instances_id` varchar(255) NOT NULL,
  `pipeline_id` bigint(20) NOT NULL DEFAULT '0',
  `job_id` bigint(20) NOT NULL DEFAULT '0',
  `project_id` bigint(20) NOT NULL,
  `project_name` varchar(255) NOT NULL,
  `project_key` varchar(255) NOT NULL,
  `quality_profile_key` varchar(255) NOT NULL,
  `quality_gate_id` bigint(20) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` varchar(255) NOT NULL,
  `cell_phone` varchar(255) DEFAULT NULL,
  `company` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email` varchar(255) NOT NULL,
  `last_modified` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `name` varchar(255) NOT NULL,
  `tell_phone` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `authority` */

insert  into `authority`(`id`,`description`,`display_name`,`auth_type`,`code`,`auth_code`) values ('b5307a8b-6e25-47f4-858b-24d32b247404','dashboard manager','관리자','dashboard','dashboard.manager',NULL);
insert  into `authority`(`id`,`description`,`display_name`,`auth_type`,`code`,`auth_code`) values ('b996ab40-29f6-4a4b-8439-530b69724247','read','보기권한','pipeline','read',NULL);
insert  into `authority`(`id`,`description`,`display_name`,`auth_type`,`code`,`auth_code`) values ('c10648f2-881a-4b1c-a449-c706734ab668','write','생성권한','pipeline','write',NULL);
insert  into `authority`(`id`,`description`,`display_name`,`auth_type`,`code`,`auth_code`) values ('ed537e6e-2f70-4d8f-a8c9-12b0f8eec09d','execute','실행권한','pipeline','execute',NULL);
insert  into `authority`(`id`,`description`,`display_name`,`auth_type`,`code`,`auth_code`) values ('f3f5b956-9d24-431a-9ab6-e55864e71179','dashboard user','사용자','dashboard','dashboard.user',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


