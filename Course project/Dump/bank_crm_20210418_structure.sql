-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: banks_crm
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts_credit`
--

DROP TABLE IF EXISTS `accounts_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_credit` (
  `id_account_credit` int unsigned NOT NULL AUTO_INCREMENT,
  `id_offer_credit` int unsigned NOT NULL,
  `id_client` int unsigned NOT NULL,
  `date_start` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_stop` datetime NOT NULL,
  `initial_credit` decimal(12,2) unsigned NOT NULL,
  `modifier` decimal(5,2) NOT NULL DEFAULT '0.00',
  `account_number` bigint unsigned NOT NULL,
  `status` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_account_credit`),
  UNIQUE KEY `account_number_UNIQUE` (`account_number`),
  UNIQUE KEY `id_account_credit_UNIQUE` (`id_account_credit`),
  KEY `fk_accounts_credit_offers_credit1_idx` (`id_offer_credit`),
  KEY `fk_accounts_credit_clients_profiles1_idx` (`id_client`),
  KEY `date_start` (`date_start`),
  KEY `date_stop` (`date_stop`),
  CONSTRAINT `fk_accounts_credit_clients_profiles1` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`),
  CONSTRAINT `fk_accounts_credit_offers_credit1` FOREIGN KEY (`id_offer_credit`) REFERENCES `offers_credit` (`id_offer_credit`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`SergeyZ06`@`%`*/ /*!50003 TRIGGER `accounts_credit_BEFORE_INSERT` BEFORE INSERT ON `accounts_credit` FOR EACH ROW BEGIN
	SET @duration = TIMESTAMPDIFF(DAY, NEW.date_start, NEW.date_stop);
	
    SET @duration_min = (
		SELECT
			banks_crm.offers_credit.duration_min
		FROM banks_crm.offers_credit
        WHERE banks_crm.offers_credit.id_offer_credit = NEW.id_offer_credit
        );

    SET @duration_max = (
		SELECT
			banks_crm.offers_credit.duration_max
		FROM banks_crm.offers_credit
        WHERE banks_crm.offers_credit.id_offer_credit = NEW.id_offer_credit
        );
	
    IF @duration < @duration_min OR @duration > @duration_max
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Error: duration is out of offer's limit";
    END IF;

	SET @limit_min = (
		SELECT
			offers_credit.limit_min
		FROM offers_credit
        WHERE offers_credit.id_offer_credit = NEW.id_offer_credit
        );

	SET @limit_max = (
		SELECT
			offers_credit.limit_max
		FROM offers_credit
        WHERE offers_credit.id_offer_credit = NEW.id_offer_credit
        );
        
	IF NEW.initial_credit < @limit_min OR NEW.initial_credit > @limit_max
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Error: initial_credit is out of offer's limit";
		END IF;

	SET NEW.modifier = (
		SELECT
			2 - FLOOR(SQRT(banks_crm.clients_resume.rating)) / 100
		FROM banks_crm.clients_resume
        WHERE banks_crm.clients_resume.id_client = NEW.id_client
        );

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `accounts_credit_status`
--

DROP TABLE IF EXISTS `accounts_credit_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_credit_status` (
  `id_account_credit` int unsigned NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `debt` decimal(12,2) unsigned NOT NULL,
  `debt_interest` decimal(12,2) unsigned NOT NULL,
  `amount_of_delay` decimal(12,2) unsigned NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_account_credit`,`timestamp`),
  KEY `fk_accounts_credit_status_accounts_credit1_idx` (`id_account_credit`),
  KEY `debt` (`debt`),
  KEY `debt_interest` (`debt_interest`),
  KEY `amount_of_delay` (`amount_of_delay`),
  KEY `timestamp` (`timestamp`),
  CONSTRAINT `fk_accounts_credit_status_accounts_credit1` FOREIGN KEY (`id_account_credit`) REFERENCES `accounts_credit` (`id_account_credit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `accounts_debit`
--

DROP TABLE IF EXISTS `accounts_debit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_debit` (
  `id_account_debit` int unsigned NOT NULL AUTO_INCREMENT,
  `id_offer_debit` int unsigned NOT NULL,
  `id_client` int unsigned NOT NULL,
  `date_start` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_stop` datetime DEFAULT NULL,
  `initial_balance` decimal(12,2) unsigned NOT NULL,
  `modifier` decimal(5,2) unsigned NOT NULL DEFAULT '0.00',
  `account_number` bigint unsigned NOT NULL,
  `status` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_account_debit`),
  UNIQUE KEY `account_number_UNIQUE` (`account_number`),
  UNIQUE KEY `id_account_debit_UNIQUE` (`id_account_debit`),
  KEY `fk_accounts_debit_offers_debit1_idx` (`id_offer_debit`),
  KEY `fk_accounts_debit_clients_profiles1_idx` (`id_client`),
  KEY `date_start` (`date_start`),
  KEY `date_stop` (`date_stop`),
  CONSTRAINT `fk_accounts_debit_clients_profiles1` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`),
  CONSTRAINT `fk_accounts_debit_offers_debit1` FOREIGN KEY (`id_offer_debit`) REFERENCES `offers_debit` (`id_offer_debit`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Duration check';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`SergeyZ06`@`%`*/ /*!50003 TRIGGER `accounts_debit_BEFORE_INSERT` BEFORE INSERT ON `accounts_debit` FOR EACH ROW BEGIN
	SET @duration = TIMESTAMPDIFF(DAY, NEW.date_start, NEW.date_stop);
	
    SET @duration_min = (
		SELECT
			banks_crm.offers_debit.duration_min
		FROM banks_crm.offers_debit
        WHERE banks_crm.offers_debit.id_offer_debit = NEW.id_offer_debit
        );

    SET @duration_max = (
		SELECT
			banks_crm.offers_debit.duration_max
		FROM banks_crm.offers_debit
        WHERE banks_crm.offers_debit.id_offer_debit = NEW.id_offer_debit
        );
	
    IF @duration < @duration_min OR @duration > @duration_max
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Error: duration is out of offer's limit";
    END IF;
	
	SET @limit_min = (
		SELECT
			offers_debit.limit_min
		FROM offers_debit
        WHERE offers_debit.id_offer_debit = NEW.id_offer_debit
        );

	SET @limit_max = (
		SELECT
			offers_debit.limit_max
		FROM offers_debit
        WHERE offers_debit.id_offer_debit = NEW.id_offer_debit
        );
        
	IF NEW.initial_balance < @limit_min OR NEW.initial_balance > @limit_max
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Error: initial_balance is out of offer's limit";
		END IF;   
    
	SET NEW.modifier = (
		SELECT
			FLOOR(SQRT(banks_crm.clients_resume.rating)) / 100
		FROM banks_crm.clients_resume
        WHERE banks_crm.clients_resume.id_client = NEW.id_client
        );
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `accounts_debit_status`
--

DROP TABLE IF EXISTS `accounts_debit_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_debit_status` (
  `id_account_debit` int unsigned NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_operation` bigint unsigned NOT NULL,
  `balance` decimal(12,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id_account_debit`,`timestamp`),
  UNIQUE KEY `id_operation_UNIQUE` (`id_operation`),
  KEY `fk_table1_accounts_debit1_idx` (`id_account_debit`),
  KEY `balance` (`balance`),
  KEY `timestamp` (`timestamp`),
  CONSTRAINT `fk_table1_accounts_debit1` FOREIGN KEY (`id_account_debit`) REFERENCES `accounts_debit` (`id_account_debit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_contacts`
--

DROP TABLE IF EXISTS `client_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_contacts` (
  `id_client` int unsigned NOT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number_additional` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `place_of_residence` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `id_client_UNIQUE` (`id_client`),
  UNIQUE KEY `phone_number_UNIQUE` (`phone_number`),
  UNIQUE KEY `phone_number_additional_UNIQUE` (`phone_number_additional`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  CONSTRAINT `fk_table1_clients_profiles2` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `client_delays`
--

DROP TABLE IF EXISTS `client_delays`;
/*!50001 DROP VIEW IF EXISTS `client_delays`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `client_delays` AS SELECT 
 1 AS `id_client`,
 1 AS `amount_days_with_delay`,
 1 AS `average_amount_of_delay`,
 1 AS `rating_decrease`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `client_social_networks`
--

DROP TABLE IF EXISTS `client_social_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client_social_networks` (
  `id_client` int unsigned NOT NULL,
  `url_social_network` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_client`,`url_social_network`),
  UNIQUE KEY `url_social_network_UNIQUE` (`url_social_network`),
  CONSTRAINT `fk_table1_clients_profiles3` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `clients_income`
--

DROP TABLE IF EXISTS `clients_income`;
/*!50001 DROP VIEW IF EXISTS `clients_income`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `clients_income` AS SELECT 
 1 AS `id_client`,
 1 AS `avg_income`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `clients_operations`
--

DROP TABLE IF EXISTS `clients_operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients_operations` (
  `id_clients_operation` int unsigned NOT NULL AUTO_INCREMENT,
  `id_clients_session` int unsigned NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount_of_money` decimal(12,2) unsigned NOT NULL,
  `account_number_from` bigint unsigned NOT NULL,
  `account_number_to` bigint unsigned NOT NULL,
  PRIMARY KEY (`id_clients_operation`),
  UNIQUE KEY `id_clients_operation_UNIQUE` (`id_clients_operation`),
  KEY `fk_clients_operations_clients_sessions1_idx` (`id_clients_session`),
  KEY `timestamp` (`timestamp`),
  KEY `amount_of_money` (`amount_of_money`),
  CONSTRAINT `fk_clients_operations_clients_sessions1` FOREIGN KEY (`id_clients_session`) REFERENCES `clients_sessions` (`id_clients_session`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clients_passports`
--

DROP TABLE IF EXISTS `clients_passports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients_passports` (
  `id_client` int unsigned NOT NULL,
  `first_name` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `patronymic` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthday` date NOT NULL,
  `birth_place` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `passport_number` bigint NOT NULL,
  `issue_date` date NOT NULL,
  `issue_department` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `issue_department_code` char(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `place_of_residence` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `passport_number_UNIQUE` (`passport_number`),
  UNIQUE KEY `id_client_UNIQUE` (`id_client`),
  KEY `passport_number` (`passport_number`),
  FULLTEXT KEY `full_name` (`first_name`,`patronymic`,`last_name`),
  CONSTRAINT `fk_clients_passports_clients_profiles` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clients_profiles`
--

DROP TABLE IF EXISTS `clients_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients_profiles` (
  `id_client` int unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_deleted` datetime DEFAULT NULL,
  `status` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `id_client_UNIQUE` (`id_client`),
  UNIQUE KEY `login_UNIQUE` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clients_resume`
--

DROP TABLE IF EXISTS `clients_resume`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients_resume` (
  `id_client` int unsigned NOT NULL,
  `rating` int unsigned NOT NULL DEFAULT '10000',
  `family_client` tinyint DEFAULT NULL,
  `salary_client` tinyint DEFAULT NULL,
  `staff_client` tinyint DEFAULT NULL,
  `id_advertisement_group` int unsigned DEFAULT NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `id_client_UNIQUE` (`id_client`),
  KEY `advertisement_group` (`id_advertisement_group`),
  CONSTRAINT `fk_table1_clients_profiles1` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clients_sessions`
--

DROP TABLE IF EXISTS `clients_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients_sessions` (
  `id_clients_session` int unsigned NOT NULL,
  `id_client` int unsigned NOT NULL,
  `id_staff` int unsigned DEFAULT NULL,
  `date_start` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_stop` datetime NOT NULL,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_type` int unsigned DEFAULT NULL,
  `ip_v4` int unsigned DEFAULT NULL,
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_clients_session`),
  UNIQUE KEY `id_clients_session_UNIQUE` (`id_clients_session`),
  KEY `fk_clients_sessions_clients_profiles1_idx` (`id_client`),
  KEY `date_start` (`date_start`),
  KEY `date_stop` (`date_stop`),
  CONSTRAINT `fk_clients_sessions_clients_profiles1` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `offers_credit`
--

DROP TABLE IF EXISTS `offers_credit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offers_credit` (
  `id_offer_credit` int unsigned NOT NULL AUTO_INCREMENT,
  `duration_min` smallint unsigned NOT NULL,
  `duration_max` smallint unsigned NOT NULL,
  `limit_min` decimal(12,2) unsigned NOT NULL,
  `limit_max` decimal(12,2) unsigned NOT NULL,
  `interest_rate` decimal(5,2) unsigned NOT NULL,
  `payment_period` smallint unsigned NOT NULL,
  `insurance` decimal(12,2) unsigned NOT NULL DEFAULT '0.00',
  `name` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_start` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_stop` datetime DEFAULT NULL,
  `status` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_offer_credit`),
  UNIQUE KEY `id_offer_credit_UNIQUE` (`id_offer_credit`),
  KEY `duration_max` (`duration_max`),
  KEY `duration_min` (`duration_min`),
  KEY `limit_max` (`limit_max`),
  KEY `limit_min` (`limit_min`),
  KEY `interest_rate` (`interest_rate`),
  KEY `date_start` (`date_start`),
  KEY `date_stop` (`date_stop`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `offers_debit`
--

DROP TABLE IF EXISTS `offers_debit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offers_debit` (
  `id_offer_debit` int unsigned NOT NULL AUTO_INCREMENT,
  `duration_min` smallint unsigned NOT NULL,
  `duration_max` smallint unsigned NOT NULL,
  `limit_min` decimal(12,2) unsigned NOT NULL,
  `limit_max` decimal(12,2) unsigned NOT NULL,
  `profitability` decimal(5,2) unsigned NOT NULL,
  `accrual_period` smallint unsigned NOT NULL,
  `insurance` decimal(12,2) unsigned NOT NULL,
  `deposit` tinyint NOT NULL DEFAULT '1',
  `withdraw` tinyint NOT NULL DEFAULT '1',
  `name` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_start` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_stop` datetime DEFAULT NULL,
  `status` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_offer_debit`),
  UNIQUE KEY `id_offer_debit_UNIQUE` (`id_offer_debit`),
  KEY `duration_max` (`duration_max`),
  KEY `duration_min` (`duration_min`),
  KEY `limit_max` (`limit_max`),
  KEY `limit_min` (`limit_min`),
  KEY `profitability` (`profitability`),
  KEY `date_start` (`date_start`),
  KEY `date_stop` (`date_stop`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'banks_crm'
--

--
-- Dumping routines for database 'banks_crm'
--
/*!50003 DROP PROCEDURE IF EXISTS `debit_income` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`SergeyZ06`@`%` PROCEDURE `debit_income`()
BEGIN
	-- Запрос для формирования графика баланса дебетовых счетов после начисления процентов
	-- Запрос реализован также ввиде процедуры "debit_income"

	WITH RECURSIVE t1 AS (
		SELECT
			ad.id_account_debit,
			ad.initial_balance,
			ad.date_start,
			ad.date_stop,
			od.accrual_period,
			ROUND(od.profitability * ad.modifier, 2) AS profitability
		FROM accounts_debit AS ad
			INNER JOIN offers_debit AS od ON od.id_offer_debit = ad.id_offer_debit
		WHERE od.profitability > 0
		UNION ALL
		SELECT
			t1.id_account_debit,
			t1.initial_balance + t1.initial_balance * t1.profitability / 100 / 12,
			DATE_ADD(t1.date_start, INTERVAL t1.accrual_period DAY),
			t1.date_stop,
			t1.accrual_period,
			t1.profitability
		FROM t1
		WHERE DATE_ADD(t1.date_start, INTERVAL t1.accrual_period DAY) <= t1.date_stop
		)

	SELECT
		t1.id_account_debit,
		t1.date_start AS accrual_date,
		t1.initial_balance AS balance
	FROM t1
	ORDER BY
		t1.id_account_debit,
		t1.date_start,
		t1.initial_balance;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `new_procedure` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`SergeyZ06`@`%` PROCEDURE `new_procedure`()
BEGIN
	SELECT * FROM banks_crm.accounts_debit;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `client_delays`
--

/*!50001 DROP VIEW IF EXISTS `client_delays`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`SergeyZ06`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `client_delays` AS select `ac`.`id_client` AS `id_client`,count(`acs`.`timestamp`) AS `amount_days_with_delay`,avg(`acs`.`amount_of_delay`) AS `average_amount_of_delay`,floor((count(`acs`.`timestamp`) * avg(sqrt(`acs`.`amount_of_delay`)))) AS `rating_decrease` from (`accounts_credit` `ac` join `accounts_credit_status` `acs` on((`acs`.`id_account_credit` = `ac`.`id_account_credit`))) where (`acs`.`amount_of_delay` > 0) group by `ac`.`id_client` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `clients_income`
--

/*!50001 DROP VIEW IF EXISTS `clients_income`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`SergeyZ06`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `clients_income` AS with `t1` as (select `ad`.`id_client` AS `id_client`,`ads`.`id_operation` AS `id_operation`,`ads`.`balance` AS `balance`,lag(`ads`.`balance`,1,0) OVER (ORDER BY `ads`.`timestamp` )  AS `before_salary` from (`accounts_debit` `ad` join `accounts_debit_status` `ads` on((`ads`.`id_account_debit` = `ad`.`id_account_debit`)))) select `t1`.`id_client` AS `id_client`,avg((`t1`.`balance` - `t1`.`before_salary`)) AS `avg_income` from `t1` where ((cast(`t1`.`id_operation` as char charset utf8mb4) like '3%') and exists(select 'test' from `clients_resume` `cr` where ((`cr`.`id_client` = `t1`.`id_client`) and (`cr`.`family_client` = true) and (`cr`.`salary_client` = true)))) group by `t1`.`id_client` having (`avg_income` > 25000) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-18 21:36:08
