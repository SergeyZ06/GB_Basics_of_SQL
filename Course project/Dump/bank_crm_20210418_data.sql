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
-- Dumping data for table `accounts_credit`
--

LOCK TABLES `accounts_credit` WRITE;
/*!40000 ALTER TABLE `accounts_credit` DISABLE KEYS */;
INSERT INTO `accounts_credit` VALUES (25,1,4,'2016-01-01 00:00:00','2016-03-01 00:00:00',50000.00,1.02,776627963145224192,'Closed'),(26,1,5,'2016-01-01 00:00:00','2016-03-01 00:00:00',70000.00,0.95,776627963145224193,'Closed'),(27,3,9,'2002-06-01 00:00:00','2011-04-20 00:00:00',8000000.00,0.98,776627963145224196,'Closed'),(28,1,2,'2021-01-01 00:00:00','2021-12-25 00:00:00',80000.00,0.97,776627963145224195,'Active'),(29,2,3,'2020-04-20 00:00:00','2024-04-19 00:00:00',1000000.00,0.94,776627963145224197,'Active'),(30,3,3,'2015-02-02 00:00:00','2024-03-25 00:00:00',7000000.00,0.94,776627963145224198,'Active'),(31,1,7,'2021-01-01 00:00:00','2021-07-01 00:00:00',40000.00,1.03,776627963145224194,'Active'),(32,2,4,'2020-07-07 00:00:00','2023-07-07 00:00:00',400000.00,1.02,776627963145224199,'Active');
/*!40000 ALTER TABLE `accounts_credit` ENABLE KEYS */;
UNLOCK TABLES;
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
-- Dumping data for table `accounts_credit_status`
--

LOCK TABLES `accounts_credit_status` WRITE;
/*!40000 ALTER TABLE `accounts_credit_status` DISABLE KEYS */;
INSERT INTO `accounts_credit_status` VALUES (28,'2021-02-01 00:00:00',75000.00,2500.00,0.00),(28,'2021-03-01 00:00:00',70000.00,2400.00,0.00),(28,'2021-04-01 00:00:00',65000.00,2300.00,0.00),(28,'2021-04-02 00:00:00',62200.00,2200.00,5000.00),(28,'2021-04-03 00:00:00',57200.00,0.00,0.00),(29,'2020-05-20 00:00:00',950000.00,19500.00,0.00),(29,'2020-06-20 00:00:00',969600.00,19600.00,50100.00),(29,'2020-06-21 00:00:00',969700.00,19700.00,50200.00),(29,'2020-06-22 00:00:00',969800.00,19800.00,50300.00),(29,'2020-06-23 00:00:00',969900.00,19900.00,50400.00),(30,'2015-03-02 00:00:00',6950000.00,40000.00,0.00),(30,'2015-04-02 00:00:00',6900000.00,39800.00,0.00),(30,'2015-05-02 00:00:00',6850000.00,39600.00,0.00),(30,'2015-06-02 00:00:00',6800000.00,39400.00,0.00),(30,'2015-07-02 00:00:00',6750000.00,39200.00,0.00),(30,'2015-08-02 00:00:00',6700000.00,39000.00,0.00),(30,'2015-09-02 00:00:00',6650000.00,38800.00,0.00),(30,'2015-10-02 00:00:00',6600000.00,38600.00,0.00),(31,'2021-02-01 00:00:00',35000.00,1600.00,0.00),(31,'2021-03-01 00:00:00',30000.00,1500.00,0.00),(31,'2021-04-01 00:00:00',25000.00,1400.00,0.00),(31,'2021-05-01 00:00:00',20000.00,1300.00,0.00),(31,'2021-06-01 00:00:00',15000.00,1200.00,0.00);
/*!40000 ALTER TABLE `accounts_credit_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `accounts_debit`
--

LOCK TABLES `accounts_debit` WRITE;
/*!40000 ALTER TABLE `accounts_debit` DISABLE KEYS */;
INSERT INTO `accounts_debit` VALUES (11,1,5,'2016-06-01 00:00:00','2016-07-01 00:00:00',50000.00,1.05,746627963145224192,'Closed'),(12,2,2,'2010-03-03 00:00:00','2012-03-02 00:00:00',2000000.00,1.03,746627963145224193,'Closed'),(13,3,7,'2021-04-10 00:00:00','2021-07-01 00:00:00',400000.00,0.97,746627963145224322,'Active'),(14,2,4,'2020-06-02 00:00:00','2022-01-02 00:00:00',3500000.00,0.98,746627963145224321,'Active'),(15,1,8,'2021-04-11 00:00:00','2021-06-10 00:00:00',70000.00,1.01,746627963145224323,'Active'),(16,4,2,'2016-11-02 00:00:00','2100-01-01 00:00:00',0.00,1.03,746627963145224194,'Active'),(17,4,10,'2000-07-20 00:00:00','2100-01-01 00:00:00',0.00,0.99,746627963145224190,'Active');
/*!40000 ALTER TABLE `accounts_debit` ENABLE KEYS */;
UNLOCK TABLES;
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
-- Dumping data for table `accounts_debit_status`
--

LOCK TABLES `accounts_debit_status` WRITE;
/*!40000 ALTER TABLE `accounts_debit_status` DISABLE KEYS */;
INSERT INTO `accounts_debit_status` VALUES (13,'2021-05-10 00:00:00',6466594329,422000.00),(13,'2021-06-10 00:00:00',6466594330,444200.00),(13,'2021-07-10 00:00:00',6466594331,466400.00),(13,'2021-08-10 00:00:00',6466294332,486000.00),(13,'2021-09-10 00:00:00',6466294333,508200.00),(16,'2017-01-01 00:00:00',3466294328,62000.00),(16,'2017-02-01 00:00:00',3466294338,124000.00),(16,'2017-03-01 00:00:00',3466294348,186000.00),(16,'2017-04-01 00:00:00',3466594358,231500.00),(17,'2000-08-07 09:00:00',3466224322,25000.00),(17,'2000-08-07 10:00:00',4466224323,0.00),(17,'2000-09-07 09:00:00',3466224324,26000.00),(17,'2000-09-07 10:00:00',4466424325,0.00),(17,'2000-10-07 09:00:00',3466424326,27500.00),(17,'2000-10-07 10:00:00',4466224327,0.00),(17,'2000-11-07 09:00:00',3466224328,28000.00),(17,'2000-11-07 10:00:00',4466224329,0.00);
/*!40000 ALTER TABLE `accounts_debit_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `client_contacts`
--

LOCK TABLES `client_contacts` WRITE;
/*!40000 ALTER TABLE `client_contacts` DISABLE KEYS */;
INSERT INTO `client_contacts` VALUES (1,'376-752-8485x13490','+05(7)7723664577',NULL,'11637 Rick Greens\nAlexystown, OR 20471'),(2,'1-247-379-4126x232',NULL,'doyle.heber@example.com',NULL),(3,'1-891-019-4203x9250','659.289.6241','gibson.carmel@example.org','05944 Cleve Springs\nPort Blaise, WI 73587-9501'),(5,'1-854-985-1747','(932)964-4266x341',NULL,'7736 Mills Union\nNorth Vida, UT 77067'),(6,NULL,NULL,'ewintheiser@example.org',NULL),(8,'1-527-788-6144','(007)979-0535x005','spinka.loyce@example.com',NULL),(9,'447.420.1789x840','(441)472-7058',NULL,'061 Alisa Flat\nSouth Princeshire, WV 72182'),(10,'905-309-6900x1733','1-659-582-1059x008','olson.kaycee@example.org','384 Wilbert Tunnel Apt. 720\nNew Maci, VT 99248');
/*!40000 ALTER TABLE `client_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `client_social_networks`
--

LOCK TABLES `client_social_networks` WRITE;
/*!40000 ALTER TABLE `client_social_networks` DISABLE KEYS */;
INSERT INTO `client_social_networks` VALUES (9,'http://farrell.com/'),(6,'http://gerlach.com/'),(5,'http://larsonward.biz/'),(3,'http://nikolausdickens.com/'),(3,'http://oberbrunnerdare.net/'),(9,'http://okuneva.com/'),(10,'http://sawayn.biz/'),(3,'http://schiller.org/'),(9,'http://schmitt.com/'),(1,'http://smithamwiza.biz/'),(5,'http://williamson.com/'),(5,'http://www.buckridgeluettgen.net/'),(10,'http://www.harris.org/'),(1,'http://www.lebsack.com/'),(1,'http://www.mohr.info/'),(3,'http://www.mooreolson.info/'),(8,'http://www.okon.com/'),(10,'http://www.runolfsdottir.com/'),(10,'http://www.schroeder.com/'),(9,'http://www.wintheiser.com/');
/*!40000 ALTER TABLE `client_social_networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `clients_operations`
--

LOCK TABLES `clients_operations` WRITE;
/*!40000 ALTER TABLE `clients_operations` DISABLE KEYS */;
INSERT INTO `clients_operations` VALUES (1,1,'2008-12-13 12:16:35',101.30,776627963145224192,0),(2,2,'2008-08-10 12:38:00',44.72,776627963145224192,776627963145224192),(3,3,'2000-07-26 23:15:59',802613.13,776627963145224192,0),(4,4,'2000-09-17 00:52:49',0.00,776627963145224192,0),(5,5,'2011-05-04 05:13:30',30418.70,0,0),(6,6,'2017-06-25 12:08:02',0.00,0,0),(7,7,'1999-07-16 14:53:07',844.43,0,0),(8,8,'2015-08-06 02:36:07',36083.55,776627963145224192,593597038652012544),(9,9,'2013-07-08 10:04:15',1285849.39,776627963145224192,776627963145224192),(10,10,'2004-07-20 15:38:22',56033.71,0,776627963145224192),(11,11,'2009-01-31 11:16:31',2.49,0,0),(12,12,'2003-07-18 14:14:24',5192772.96,776627963145224192,776627963145224192),(13,13,'2006-11-12 22:39:50',12908.54,776627963145224192,0),(14,14,'2001-05-03 21:10:35',75282079.07,776627963145224192,776627963145224192),(15,15,'2014-10-28 11:02:21',64149.30,0,776627963145224192),(16,16,'2004-01-31 05:45:12',288252.09,776627963145224192,0),(17,17,'2011-10-26 02:03:13',831.61,776627963145224192,776627963145224192),(18,18,'2003-10-24 08:43:22',0.00,0,0),(19,19,'2014-08-11 22:06:06',164.63,275563160183861248,776627963145224192),(20,20,'2016-11-28 10:35:56',0.00,0,0),(21,1,'2008-12-13 12:15:49',0.00,776627963145224192,284438746548745216),(22,2,'2008-08-10 12:40:31',0.00,0,93968037583758336),(23,3,'2000-07-26 23:15:17',76877.23,776627963145224192,776627963145224192),(24,4,'2000-09-17 00:53:26',9306606.55,776627963145224192,0),(25,5,'2011-05-04 05:28:27',27801092.31,776627963145224192,0),(26,6,'2017-06-25 12:05:55',165.11,0,0),(27,7,'1999-07-16 14:39:47',4587.96,0,0),(28,8,'2015-08-06 02:47:29',261.00,0,776627963145224192),(29,9,'2013-07-08 10:09:20',56803.41,776627963145224192,266357573044901888),(30,10,'2004-07-20 15:34:34',8253.18,0,0);
/*!40000 ALTER TABLE `clients_operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `clients_passports`
--

LOCK TABLES `clients_passports` WRITE;
/*!40000 ALTER TABLE `clients_passports` DISABLE KEYS */;
INSERT INTO `clients_passports` VALUES (1,'Mohammad','Skye','Cassin','m','1982-07-11','495 Hirthe Forges Apt. 052\nJuanamouth, MI 73793-8490',3927210296,'2002-07-11','empower distributed supply-chains','313-876','74204 Michaela Bypass Suite 973\nLake Edgardo, UT 84688'),(2,'Jaydon','Jadon','Leffler','f','1989-06-17','8802 Haley Meadow Suite 975\nNew Abraham, TX 18851-9083',4289460343,'2009-06-17','e-enable distributed convergence','639-468','49181 Fanny Lane\nSouth Jadastad, ID 27055-4309'),(3,'Maude','Sonny','Nicolas','m','1985-04-28','84723 Rice Mill Suite 982\nWest Martinestad, TX 82792',9163713112,'2005-04-28','aggregate extensible relationships','323-110','0617 Alvena Dale\nLake Angiefort, ID 77871'),(4,'Holden','Vincent','Russel','f','1994-12-05','9237 Heidi View\nGonzalotown, SC 01501-9631',8494945642,'2014-12-05','benchmark synergistic convergence','380-570','98637 Kiehn Flat Suite 746\nStiedemannmouth, LA 69118'),(5,'Preston','Mitchel','McClure','f','1994-05-15','102 Ciara Ville\nPort Sammy, PA 90795-2431',8118941139,'2014-05-15','transition sexy paradigms','708-832','227 Mohammed Ridges Suite 992\nNew Damon, UT 83882-0544'),(6,'Jess','Kyle','Kulas','m','1992-03-01','9420 Jerad Centers\nNew Buck, NY 43934-3417',7444928715,'2012-03-01','incentivize clicks-and-mortar ROI','135-777','4766 Koch Way Suite 440\nEast Fidelstad, GA 92568-1813'),(7,'Carleton','Riley','Ryan','f','1986-04-16','863 Vivienne Fords\nRuntehaven, VA 94605',1549596340,'2006-04-16','redefine robust users','680-967','3979 Crona Ramp\nNorth Calebchester, NJ 86141'),(8,'Kitty','Jean','Ledner','m','1977-11-12','44579 Norma Shoal Suite 582\nNorth Adonis, MD 39313-0626',6475783457,'1997-11-12','synergize wireless supply-chains','896-577','96503 Desmond Garden Apt. 535\nEast Florenciobury, AK 60602-7613'),(9,'Taylor','Ezra','Gaylord','f','1980-12-31','088 Waters Island\nVolkmanchester, TN 30026-1198',5335135265,'2000-12-31','monetize interactive web-readiness','999-462','30199 Darrel Causeway Apt. 008\nMarinaton, NY 66411'),(10,'Darrell','Wilburn','Macejkovic','m','1978-07-23','93365 Ahmad Haven Apt. 583\nNorth Rosendo, KY 16701',7730775472,'1998-07-23','exploit synergistic deliverables','112-872','086 Howell Meadows\nWest Efren, OR 65455');
/*!40000 ALTER TABLE `clients_passports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `clients_profiles`
--

LOCK TABLES `clients_profiles` WRITE;
/*!40000 ALTER TABLE `clients_profiles` DISABLE KEYS */;
INSERT INTO `clients_profiles` VALUES (1,'mollitia','6a00c5c9dcfa58e5c35ee9ccaf9f21a2f2710a4b','2003-01-03 12:36:22',NULL,'Active'),(2,'aut','12027854a6beb3abb2518718cd30110a003ecf42','2009-08-19 06:57:48',NULL,'Active'),(3,'quasi','10baa2a499d6377a39da25ae9740374e67452b59','2006-04-02 18:50:56',NULL,'Active'),(4,'adipisci','26eb1b4dd583061ba1b09578b35f4e9269e73602','2015-01-22 07:27:36',NULL,'Active'),(5,'voluptas','b1d1669e4b994abf9108dcfe43d2de980ef28520','2014-07-10 20:05:57','2016-07-02 00:00:00','Closed'),(6,'voluptatum','3e42f9ab23b95d9e06b123e5a3d4b676e3896f57','2012-11-20 02:44:41',NULL,'Active'),(7,'minima','69a541f2a97198eccda3c36fb33765d6c25a0a21','2006-09-07 15:15:39',NULL,'Active'),(8,'corrupti','3b7e3da537e26685eaa91390eb1b2eac2b19cf11','1998-11-09 01:15:07',NULL,'Active'),(9,'sequi','f413b514724e5ab663aacf53c72db9a4901aa036','2001-04-14 06:26:34',NULL,'Active'),(10,'quisquam','673a19b38c43006b678ac702bfd0839366fd76fe','1999-01-16 15:08:39',NULL,'Active');
/*!40000 ALTER TABLE `clients_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `clients_resume`
--

LOCK TABLES `clients_resume` WRITE;
/*!40000 ALTER TABLE `clients_resume` DISABLE KEYS */;
INSERT INTO `clients_resume` VALUES (1,11079,1,1,0,3),(2,10719,1,1,1,1),(3,11358,0,1,1,0),(4,9634,1,0,1,1),(5,11096,0,0,1,0),(6,11577,0,0,0,2),(7,9599,0,1,0,0),(8,10266,0,0,1,3),(9,10531,0,0,1,0),(10,9859,1,1,1,1);
/*!40000 ALTER TABLE `clients_resume` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `clients_sessions`
--

LOCK TABLES `clients_sessions` WRITE;
/*!40000 ALTER TABLE `clients_sessions` DISABLE KEYS */;
INSERT INTO `clients_sessions` VALUES (1,3,10,'2008-12-13 11:49:02','2008-12-13 12:19:00','Visiting website',4294967295,4294967295,NULL),(2,7,NULL,'2008-08-10 12:37:47','2008-08-10 12:42:07','Visiting website',4294967295,4294967295,NULL),(3,10,8,'2000-07-26 23:05:02','2000-07-26 23:26:48','Calling bank office',1805439688,NULL,'577-181-4588'),(4,8,NULL,'2000-09-17 00:50:44','2000-09-17 00:56:33','ATM',410492860,NULL,NULL),(5,2,NULL,'2011-05-04 05:06:47','2011-05-04 05:30:36','ATM',2966297897,NULL,NULL),(6,5,10,'2017-06-25 12:04:06','2017-06-25 12:15:46','Mobile application',4294967295,4294967295,NULL),(7,8,NULL,'1999-07-16 14:38:57','1999-07-16 14:55:48','ATM',4294967295,NULL,NULL),(8,4,NULL,'2015-08-06 02:32:24','2015-08-06 02:51:42','Mobile application',2901266441,4294967295,NULL),(9,6,10,'2013-07-08 09:57:15','2013-07-08 10:13:11','Visiting bank office',4294967295,NULL,NULL),(10,1,NULL,'2004-07-20 15:24:50','2004-07-20 15:46:38','ATM',423851301,NULL,NULL),(11,3,2,'2009-01-31 11:15:36','2009-01-31 11:16:46','Visiting bank office',3485824817,NULL,NULL),(12,1,NULL,'2003-07-18 14:14:23','2003-07-18 14:14:49','Mobile application',4294967295,4294967295,NULL),(13,7,NULL,'2006-11-12 22:11:46','2006-11-12 22:40:27','Visiting website',788594844,4294967295,NULL),(14,10,9,'2001-05-03 20:55:15','2001-05-03 21:17:24','Mobile application',1034558012,4294967295,NULL),(15,6,1,'2014-10-28 10:49:24','2014-10-28 11:14:06','Mobile application',4294967295,1342155431,NULL),(16,9,NULL,'2004-01-31 05:30:26','2004-01-31 05:57:29','ATM',177359075,NULL,NULL),(17,2,10,'2011-10-26 02:03:02','2011-10-26 02:04:12','Calling bank office',2325598217,NULL,'1-321-382-7046'),(18,9,1,'2003-10-24 08:41:10','2003-10-24 08:55:51','Calling bank office',4294967295,NULL,'011-500-7476x453'),(19,5,NULL,'2014-08-11 22:03:20','2014-08-11 22:13:14','ATM',4294967295,NULL,NULL),(20,4,10,'2016-11-28 10:30:47','2016-11-28 10:36:14','Visiting bank office',1099077540,NULL,NULL);
/*!40000 ALTER TABLE `clients_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `offers_credit`
--

LOCK TABLES `offers_credit` WRITE;
/*!40000 ALTER TABLE `offers_credit` DISABLE KEYS */;
INSERT INTO `offers_credit` VALUES (1,30,360,5000.00,100000.00,7.50,30,0.00,'Household_technics','2000-01-01 00:00:00',NULL,'Active'),(2,180,1800,100000.00,1000000.00,8.00,30,0.00,'Cars','2000-01-01 00:00:00',NULL,'Active'),(3,1800,3600,1000000.00,10000000.00,5.50,30,1400000.00,'Housing','2000-01-01 00:00:00',NULL,'Active');
/*!40000 ALTER TABLE `offers_credit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `offers_debit`
--

LOCK TABLES `offers_debit` WRITE;
/*!40000 ALTER TABLE `offers_debit` DISABLE KEYS */;
INSERT INTO `offers_debit` VALUES (1,30,90,1000.00,1000000.00,4.50,30,1400000.00,1,1,'Debit_basic','2000-01-01 00:00:00',NULL,'Active'),(2,90,900,100000.00,10000000.00,6.50,90,1400000.00,0,0,'Debit_advanced','2000-01-01 00:00:00',NULL,'Active'),(3,30,90,1000.00,1000000.00,5.50,30,1400000.00,1,0,'Debit_saving','2000-01-01 00:00:00',NULL,'Active'),(4,0,36500,0.00,100000000.00,0.00,0,1400000.00,1,1,'Debit_usual','2000-01-01 00:00:00',NULL,'Active');
/*!40000 ALTER TABLE `offers_debit` ENABLE KEYS */;
UNLOCK TABLES;

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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-18 21:37:07
