CREATE DATABASE `mks_ps_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE DATABASE  `mks_ps_db`;

CREATE TABLE `controllers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ip` varchar(64) NOT NULL,
  `port` int NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `main` int NOT NULL DEFAULT '0',
  `last_ping` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The host vm/hardware controllers which coordinate ';

CREATE TABLE `platforms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ip` varchar(64) NOT NULL,
  `port` int NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  `last_ping` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The host vm/hardware platforms on which applications/locations are run';

CREATE TABLE `applications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `path` varchar(1024) NOT NULL,
  `command_line1` varchar(1024) NOT NULL,
  `command_line2` varchar(1024) NOT NULL,
  `tag` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='The applications which can be launched on each platform ';
