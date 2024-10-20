-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               9.0.1 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for new
CREATE DATABASE IF NOT EXISTS `new` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `new`;

-- Dumping structure for table new.admin
CREATE TABLE IF NOT EXISTS `admin` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table new.admin: ~1 rows (approximately)
REPLACE INTO `admin` (`id`, `name`, `email`, `password`) VALUES
	(1, 'admin', 'admin@gmail.com', '12345678'),
	(2, 'bank 1', 'bank1@gmail.com', 'bank1');

-- Dumping structure for table new.bank
CREATE TABLE IF NOT EXISTS `bank` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_name` varchar(100) DEFAULT NULL,
  `nic` varchar(45) DEFAULT NULL,
  `ac_num` varchar(45) NOT NULL,
  `gender_id` int NOT NULL,
  `loan_amount` int DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `upto_date` date DEFAULT NULL,
  PRIMARY KEY (`ac_num`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `nic` (`nic`),
  KEY `fk_bank_usergen_idx` (`gender_id`),
  CONSTRAINT `fk_bank_usergen` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table new.bank: ~16 rows (approximately)
REPLACE INTO `bank` (`id`, `owner_name`, `nic`, `ac_num`, `gender_id`, `loan_amount`, `start_date`, `upto_date`) VALUES
	(58, 'user 1', '200318810201', '00001', 1, 45000, '2024-10-20', '2024-11-09'),
	(56, 'user 1', '2000987654', '344556', 1, 560000, '2024-10-20', '2024-11-09');

-- Dumping structure for table new.bank_process
CREATE TABLE IF NOT EXISTS `bank_process` (
  `id` int NOT NULL AUTO_INCREMENT,
  `credit_office` int DEFAULT NULL,
  `bank_manager` int DEFAULT NULL,
  `mail_unit` int DEFAULT NULL,
  `bank_ac` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`bank_ac`) USING BTREE,
  CONSTRAINT `FK_bank_process_bank` FOREIGN KEY (`bank_ac`) REFERENCES `bank` (`ac_num`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table new.bank_process: ~9 rows (approximately)
REPLACE INTO `bank_process` (`id`, `credit_office`, `bank_manager`, `mail_unit`, `bank_ac`) VALUES
	(1, 1, 2, 2, NULL),
	(30, 2, 2, 1, '00001');

-- Dumping structure for table new.gender
CREATE TABLE IF NOT EXISTS `gender` (
  `id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table new.gender: ~3 rows (approximately)
REPLACE INTO `gender` (`id`, `name`) VALUES
	(1, 'male'),
	(2, 'female'),
	(3, 'other');

-- Dumping structure for table new.head_office
CREATE TABLE IF NOT EXISTS `head_office` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branch_cu` int DEFAULT NULL,
  `credit_office` int DEFAULT NULL,
  `ag_manager` int DEFAULT NULL,
  `dg_manager` int DEFAULT NULL,
  `bank_ac` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`bank_ac`) USING BTREE,
  CONSTRAINT `FK_head_office_bank` FOREIGN KEY (`bank_ac`) REFERENCES `bank` (`ac_num`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table new.head_office: ~5 rows (approximately)
REPLACE INTO `head_office` (`id`, `branch_cu`, `credit_office`, `ag_manager`, `dg_manager`, `bank_ac`) VALUES
	(1, 1, 2, 1, 2, '344556'),
	(23, 1, 2, 2, 1, '00001');

-- Dumping structure for table new.loan
CREATE TABLE IF NOT EXISTS `loan` (
  `loan_id` int NOT NULL AUTO_INCREMENT,
  `loan_amount` varchar(50) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `upto_date` date DEFAULT NULL,
  `bank_ac_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `bank_process_id` int DEFAULT NULL,
  `province_office_id` int DEFAULT NULL,
  `head_office_id` int DEFAULT NULL,
  PRIMARY KEY (`loan_id`) USING BTREE,
  KEY `fk_loan_bank1_idx` (`bank_ac_num`),
  KEY `bank_process_id` (`bank_process_id`),
  KEY `province_office_id` (`province_office_id`),
  KEY `head_office_id` (`head_office_id`),
  CONSTRAINT `FK_loan_bank` FOREIGN KEY (`bank_ac_num`) REFERENCES `bank` (`ac_num`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table new.loan: ~0 rows (approximately)

-- Dumping structure for table new.province_office
CREATE TABLE IF NOT EXISTS `province_office` (
  `id` int NOT NULL AUTO_INCREMENT,
  `credit_officer` int DEFAULT NULL,
  `area_manager` int DEFAULT NULL,
  `ag_manager` int DEFAULT NULL,
  `mail_unit` int DEFAULT NULL,
  `bank_ac` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`bank_ac`) USING BTREE,
  CONSTRAINT `FK_province_office_bank` FOREIGN KEY (`bank_ac`) REFERENCES `bank` (`ac_num`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table new.province_office: ~4 rows (approximately)
REPLACE INTO `province_office` (`id`, `credit_officer`, `area_manager`, `ag_manager`, `mail_unit`, `bank_ac`) VALUES
	(1, 2, 2, 2, 2, '344556'),
	(22, 1, 2, 2, 1, '00001');

-- Dumping structure for table new.status
CREATE TABLE IF NOT EXISTS `status` (
  `id` int NOT NULL,
  `status_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table new.status: ~0 rows (approximately)

-- Dumping structure for table new.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `bank_ac_num` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bank_ac_num` (`bank_ac_num`),
  CONSTRAINT `FK_user_bank` FOREIGN KEY (`bank_ac_num`) REFERENCES `bank` (`ac_num`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table new.user: ~1 rows (approximately)
REPLACE INTO `user` (`id`, `name`, `email`, `password`, `bank_ac_num`) VALUES
	(1, 'vbank1', 'bank1@gmail.com', 'vbank1', '344556');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
