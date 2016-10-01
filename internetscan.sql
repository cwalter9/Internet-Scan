/*
SQLyog Community v12.2.5 (64 bit)
MySQL - 5.5.50-MariaDB : Database - internetscan
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`internetscan` /*!40100 DEFAULT CHARACTER SET latin1 */;

/*Table structure for table `address` */

DROP TABLE IF EXISTS `address`;

CREATE TABLE `address` (
  `addid` int(250) NOT NULL AUTO_INCREMENT,
  `oct1` int(6) NOT NULL,
  `oct2` int(6) DEFAULT NULL,
  `oct3` int(6) DEFAULT NULL,
  `oct4` int(11) DEFAULT NULL,
  `ipaddr` varchar(20) DEFAULT NULL,
  `status` int(4) DEFAULT '0',
  `adddate` date DEFAULT NULL,
  `updown` int(3) DEFAULT NULL,
  PRIMARY KEY (`addid`,`oct1`),
  UNIQUE KEY `IPADDR` (`oct1`,`oct2`,`oct3`,`oct4`),
  UNIQUE KEY `idaddress` (`addid`,`ipaddr`),
  UNIQUE KEY `addstat` (`addid`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=205965 DEFAULT CHARSET=latin1;

/*Table structure for table `log` */

DROP TABLE IF EXISTS `log`;

CREATE TABLE `log` (
  `id` int(240) NOT NULL AUTO_INCREMENT,
  `pid` varchar(16) NOT NULL,
  `entry` varchar(240) DEFAULT NULL,
  `ltime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`,`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=45525 DEFAULT CHARSET=latin1;

/*Table structure for table `ports` */

DROP TABLE IF EXISTS `ports`;

CREATE TABLE `ports` (
  `poid` int(250) NOT NULL AUTO_INCREMENT,
  `addid` int(250) NOT NULL,
  `port` int(8) DEFAULT NULL,
  `status` int(4) DEFAULT '0',
  `chtime` int(12) DEFAULT NULL,
  PRIMARY KEY (`poid`,`addid`),
  UNIQUE KEY `idportstat` (`poid`,`port`,`status`),
  UNIQUE KEY `statidadd` (`poid`,`addid`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=68496 DEFAULT CHARSET=latin1;

/*Table structure for table `service` */

DROP TABLE IF EXISTS `service`;

CREATE TABLE `service` (
  `sid` int(250) NOT NULL AUTO_INCREMENT,
  `addid` int(250) NOT NULL,
  `poid` int(250) NOT NULL,
  `service` varchar(64) DEFAULT NULL,
  `tstamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`sid`,`addid`,`poid`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

/*Table structure for table `vars` */

DROP TABLE IF EXISTS `vars`;

CREATE TABLE `vars` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `vname` varchar(64) DEFAULT NULL,
  `vfield` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Table structure for table `hostports` */

DROP TABLE IF EXISTS `hostports`;

/*!50001 DROP VIEW IF EXISTS `hostports` */;
/*!50001 DROP TABLE IF EXISTS `hostports` */;

/*!50001 CREATE TABLE  `hostports`(
 `addid` int(250) ,
 `ipaddr` varchar(20) ,
 `port` int(8) 
)*/;

/*Table structure for table `vw_services` */

DROP TABLE IF EXISTS `vw_services`;

/*!50001 DROP VIEW IF EXISTS `vw_services` */;
/*!50001 DROP TABLE IF EXISTS `vw_services` */;

/*!50001 CREATE TABLE  `vw_services`(
 `Service` varchar(64) ,
 `Address` varchar(20) ,
 `PORT` int(8) ,
 `Time Stamp` timestamp 
)*/;

/*View structure for view hostports */

/*!50001 DROP TABLE IF EXISTS `hostports` */;
/*!50001 DROP VIEW IF EXISTS `hostports` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`admincw`@`%` SQL SECURITY DEFINER VIEW `hostports` AS select `address`.`addid` AS `addid`,`address`.`ipaddr` AS `ipaddr`,`ports`.`port` AS `port` from (`address` left join `ports` on((`address`.`addid` = `ports`.`addid`))) */;

/*View structure for view vw_services */

/*!50001 DROP TABLE IF EXISTS `vw_services` */;
/*!50001 DROP VIEW IF EXISTS `vw_services` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`admincw`@`%` SQL SECURITY DEFINER VIEW `vw_services` AS select `service`.`service` AS `Service`,`address`.`ipaddr` AS `Address`,`ports`.`port` AS `PORT`,`service`.`tstamp` AS `Time Stamp` from (`service` left join (`address` join `ports`) on(((`address`.`addid` = `service`.`addid`) and (`ports`.`poid` = `service`.`poid`)))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
