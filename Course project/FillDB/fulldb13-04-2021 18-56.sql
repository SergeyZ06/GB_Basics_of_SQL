#
# TABLE STRUCTURE FOR: account_debit_status
#

DROP TABLE IF EXISTS `account_debit_status`;

CREATE TABLE `account_debit_status` (
  `accounts_debit_id_account_debit` int(10) unsigned NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `balance` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`accounts_debit_id_account_debit`,`timestamp`),
  KEY `fk_table1_accounts_debit1_idx` (`accounts_debit_id_account_debit`),
  KEY `balance` (`balance`),
  KEY `timestamp` (`timestamp`),
  CONSTRAINT `fk_table1_accounts_debit1` FOREIGN KEY (`accounts_debit_id_account_debit`) REFERENCES `accounts_debit` (`id_account_debit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#
# TABLE STRUCTURE FOR: accounts_credit
#

DROP TABLE IF EXISTS `accounts_credit`;

CREATE TABLE `accounts_credit` (
  `id_account_credit` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_offer_credit` int(10) unsigned NOT NULL,
  `id_client` int(10) unsigned NOT NULL,
  `date_start` datetime NOT NULL DEFAULT current_timestamp(),
  `date_stop` datetime NOT NULL,
  `modifier` decimal(5,2) NOT NULL DEFAULT 0.00,
  `account_number` bigint(20) unsigned NOT NULL,
  `status` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_account_credit`),
  UNIQUE KEY `account_number_UNIQUE` (`account_number`),
  UNIQUE KEY `id_account_credit_UNIQUE` (`id_account_credit`),
  KEY `fk_accounts_credit_offers_credit1_idx` (`id_offer_credit`),
  KEY `fk_accounts_credit_clients_profiles1_idx` (`id_client`),
  KEY `date_start` (`date_start`),
  KEY `date_stop` (`date_stop`),
  CONSTRAINT `fk_accounts_credit_clients_profiles1` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`),
  CONSTRAINT `fk_accounts_credit_offers_credit1` FOREIGN KEY (`id_offer_credit`) REFERENCES `offers_credit` (`id_offer_credit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#
# TABLE STRUCTURE FOR: accounts_credit_status
#

DROP TABLE IF EXISTS `accounts_credit_status`;

CREATE TABLE `accounts_credit_status` (
  `id_account_credit` int(10) unsigned NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `debt` decimal(12,2) unsigned NOT NULL,
  `debt_interest` decimal(12,2) unsigned NOT NULL,
  `amount_of_delay` decimal(12,2) unsigned NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id_account_credit`,`timestamp`),
  KEY `fk_accounts_credit_status_accounts_credit1_idx` (`id_account_credit`),
  KEY `debt` (`debt`),
  KEY `debt_interest` (`debt_interest`),
  KEY `amount_of_delay` (`amount_of_delay`),
  KEY `timestamp` (`timestamp`),
  CONSTRAINT `fk_accounts_credit_status_accounts_credit1` FOREIGN KEY (`id_account_credit`) REFERENCES `accounts_credit` (`id_account_credit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#
# TABLE STRUCTURE FOR: accounts_debit
#

DROP TABLE IF EXISTS `accounts_debit`;

CREATE TABLE `accounts_debit` (
  `id_account_debit` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_offer_debit` int(10) unsigned NOT NULL,
  `id_client` int(10) unsigned NOT NULL,
  `date_start` datetime NOT NULL DEFAULT current_timestamp(),
  `date_stop` datetime DEFAULT NULL,
  `modifier` decimal(5,2) unsigned NOT NULL DEFAULT 0.00,
  `account_number` bigint(20) unsigned NOT NULL,
  `status` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_account_debit`),
  UNIQUE KEY `account_number_UNIQUE` (`account_number`),
  UNIQUE KEY `id_account_debit_UNIQUE` (`id_account_debit`),
  KEY `fk_accounts_debit_offers_debit1_idx` (`id_offer_debit`),
  KEY `fk_accounts_debit_clients_profiles1_idx` (`id_client`),
  KEY `date_start` (`date_start`),
  KEY `date_stop` (`date_stop`),
  CONSTRAINT `fk_accounts_debit_clients_profiles1` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`),
  CONSTRAINT `fk_accounts_debit_offers_debit1` FOREIGN KEY (`id_offer_debit`) REFERENCES `offers_debit` (`id_offer_debit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#
# TABLE STRUCTURE FOR: client_contacts
#

DROP TABLE IF EXISTS `client_contacts`;

CREATE TABLE `client_contacts` (
  `id_client` int(10) unsigned NOT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_number_additional` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `place_of_residence` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `id_client_UNIQUE` (`id_client`),
  UNIQUE KEY `phone_number_UNIQUE` (`phone_number`),
  UNIQUE KEY `phone_number_additional_UNIQUE` (`phone_number_additional`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  CONSTRAINT `fk_table1_clients_profiles2` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `client_contacts` (`id_client`, `phone_number`, `phone_number_additional`, `email`, `place_of_residence`) VALUES (1, '376-752-8485x13490', '+05(7)7723664577', 'bnikolaus@example.org', '11637 Rick Greens\nAlexystown, OR 20471');
INSERT INTO `client_contacts` (`id_client`, `phone_number`, `phone_number_additional`, `email`, `place_of_residence`) VALUES (2, '1-247-379-4126x232', '1-946-223-5663', 'doyle.heber@example.com', '34178 Jast Station\nMiaberg, IL 05480');
INSERT INTO `client_contacts` (`id_client`, `phone_number`, `phone_number_additional`, `email`, `place_of_residence`) VALUES (3, '1-891-019-4203x9250', '659.289.6241', 'gibson.carmel@example.org', '05944 Cleve Springs\nPort Blaise, WI 73587-9501');
INSERT INTO `client_contacts` (`id_client`, `phone_number`, `phone_number_additional`, `email`, `place_of_residence`) VALUES (4, '01725734539', '1-655-770-5636', 'bartoletti.malika@example.org', '9253 Conroy Lane\nNew Marcelo, MI 89345');
INSERT INTO `client_contacts` (`id_client`, `phone_number`, `phone_number_additional`, `email`, `place_of_residence`) VALUES (5, '1-854-985-1747', '(932)964-4266x341', 'stroman.eloy@example.com', '7736 Mills Union\nNorth Vida, UT 77067');
INSERT INTO `client_contacts` (`id_client`, `phone_number`, `phone_number_additional`, `email`, `place_of_residence`) VALUES (6, '186.525.9040x21176', '444.209.0211x97702', 'ewintheiser@example.org', '920 Anderson Row\nHahnborough, IL 92370');
INSERT INTO `client_contacts` (`id_client`, `phone_number`, `phone_number_additional`, `email`, `place_of_residence`) VALUES (7, '(218)323-0629', '+28(9)1728717074', 'tyra15@example.com', '6877 Joe Shore\nRafaelabury, HI 10843-5466');
INSERT INTO `client_contacts` (`id_client`, `phone_number`, `phone_number_additional`, `email`, `place_of_residence`) VALUES (8, '1-527-788-6144', '(007)979-0535x005', 'spinka.loyce@example.com', '316 Hirthe Roads Apt. 949\nLake Daren, IL 09584');
INSERT INTO `client_contacts` (`id_client`, `phone_number`, `phone_number_additional`, `email`, `place_of_residence`) VALUES (9, '447.420.1789x840', '(441)472-7058', 'corwin.linwood@example.com', '061 Alisa Flat\nSouth Princeshire, WV 72182');
INSERT INTO `client_contacts` (`id_client`, `phone_number`, `phone_number_additional`, `email`, `place_of_residence`) VALUES (10, '905-309-6900x1733', '1-659-582-1059x008', 'olson.kaycee@example.org', '384 Wilbert Tunnel Apt. 720\nNew Maci, VT 99248');


#
# TABLE STRUCTURE FOR: client_social_networks
#

DROP TABLE IF EXISTS `client_social_networks`;

CREATE TABLE `client_social_networks` (
  `id_client` int(10) unsigned NOT NULL,
  `url_social_network` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_client`,`url_social_network`),
  UNIQUE KEY `url_social_network_UNIQUE` (`url_social_network`),
  CONSTRAINT `fk_table1_clients_profiles3` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (1, 'http://smithamwiza.biz/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (1, 'http://www.lebsack.com/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (1, 'http://www.mohr.info/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (3, 'http://nikolausdickens.com/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (3, 'http://oberbrunnerdare.net/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (3, 'http://schiller.org/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (3, 'http://www.mooreolson.info/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (5, 'http://larsonward.biz/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (5, 'http://williamson.com/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (5, 'http://www.buckridgeluettgen.net/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (6, 'http://gerlach.com/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (8, 'http://www.okon.com/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (9, 'http://farrell.com/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (9, 'http://okuneva.com/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (9, 'http://schmitt.com/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (9, 'http://www.wintheiser.com/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (10, 'http://sawayn.biz/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (10, 'http://www.harris.org/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (10, 'http://www.runolfsdottir.com/');
INSERT INTO `client_social_networks` (`id_client`, `url_social_network`) VALUES (10, 'http://www.schroeder.com/');


#
# TABLE STRUCTURE FOR: clients_operations
#

DROP TABLE IF EXISTS `clients_operations`;

CREATE TABLE `clients_operations` (
  `id_clients_operation` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_clients_session` int(10) unsigned NOT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `amount_of_money` decimal(12,2) unsigned NOT NULL,
  `account_number_from` bigint(20) unsigned NOT NULL,
  `account_number_to` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id_clients_operation`),
  UNIQUE KEY `id_clients_operation_UNIQUE` (`id_clients_operation`),
  KEY `fk_clients_operations_clients_sessions1_idx` (`id_clients_session`),
  KEY `timestamp` (`timestamp`),
  KEY `amount_of_money` (`amount_of_money`),
  CONSTRAINT `fk_clients_operations_clients_sessions1` FOREIGN KEY (`id_clients_session`) REFERENCES `clients_sessions` (`id_clients_session`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (1, 1, '1998-02-07 05:35:21', '101.30', '776627963145224192', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (2, 2, '2010-03-18 09:35:56', '44.72', '776627963145224192', '776627963145224192');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (3, 3, '1988-02-11 21:47:32', '802613.13', '776627963145224192', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (4, 4, '1990-02-28 00:38:20', '0.00', '776627963145224192', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (5, 5, '2002-01-01 08:54:31', '30418.70', '0', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (6, 6, '1990-09-08 02:37:50', '0.00', '0', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (7, 7, '2020-01-17 00:01:19', '844.43', '0', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (8, 8, '1971-11-09 22:56:39', '36083.55', '776627963145224192', '593597038652012544');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (9, 9, '1979-11-29 12:18:45', '1285849.39', '776627963145224192', '776627963145224192');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (10, 10, '1984-04-04 20:42:00', '56033.71', '0', '776627963145224192');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (11, 11, '1978-02-23 15:05:03', '2.49', '0', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (12, 12, '1992-10-11 21:53:38', '5192772.96', '776627963145224192', '776627963145224192');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (13, 13, '2014-03-29 03:52:04', '12908.54', '776627963145224192', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (14, 14, '1988-05-28 02:58:03', '75282079.07', '776627963145224192', '776627963145224192');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (15, 15, '1991-05-10 11:34:01', '64149.30', '0', '776627963145224192');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (16, 16, '2004-03-27 16:01:12', '288252.09', '776627963145224192', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (17, 17, '2014-01-07 17:51:51', '831.61', '776627963145224192', '776627963145224192');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (18, 18, '1996-08-12 22:47:56', '0.00', '0', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (19, 19, '1983-04-14 10:41:15', '164.63', '275563160183861248', '776627963145224192');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (20, 20, '2015-09-14 12:52:03', '0.00', '0', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (21, 1, '2014-09-18 01:27:04', '0.00', '776627963145224192', '284438746548745216');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (22, 2, '1988-01-06 13:10:03', '0.00', '0', '93968037583758336');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (23, 3, '1993-09-14 17:13:54', '76877.23', '776627963145224192', '776627963145224192');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (24, 4, '1994-02-06 18:30:31', '9306606.55', '776627963145224192', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (25, 5, '2007-09-18 04:37:12', '27801092.31', '776627963145224192', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (26, 6, '1988-07-06 06:59:22', '165.11', '0', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (27, 7, '2000-01-18 14:51:27', '4587.96', '0', '0');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (28, 8, '1981-05-29 10:16:46', '261.00', '0', '776627963145224192');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (29, 9, '1983-12-20 09:29:00', '56803.41', '776627963145224192', '266357573044901888');
INSERT INTO `clients_operations` (`id_clients_operation`, `id_clients_session`, `timestamp`, `amount_of_money`, `account_number_from`, `account_number_to`) VALUES (30, 10, '2000-12-15 22:19:50', '8253.18', '0', '0');


#
# TABLE STRUCTURE FOR: clients_passports
#

DROP TABLE IF EXISTS `clients_passports`;

CREATE TABLE `clients_passports` (
  `id_client` int(10) unsigned NOT NULL,
  `first_name` varchar(65) COLLATE utf8mb4_unicode_ci NOT NULL,
  `patronymic` varchar(65) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(65) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthday` date NOT NULL,
  `birth_place` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `passport_number` bigint(10) NOT NULL,
  `issue_date` date NOT NULL,
  `issue_department` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `issue_department_code` char(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `place_of_residence` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `passport_number_UNIQUE` (`passport_number`),
  UNIQUE KEY `id_client_UNIQUE` (`id_client`),
  KEY `passport_number` (`passport_number`),
  FULLTEXT KEY `full_name` (`first_name`,`patronymic`,`last_name`),
  CONSTRAINT `fk_clients_passports_clients_profiles` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `clients_passports` (`id_client`, `first_name`, `patronymic`, `last_name`, `gender`, `birthday`, `birth_place`, `passport_number`, `issue_date`, `issue_department`, `issue_department_code`, `place_of_residence`) VALUES (1, 'Mohammad', 'Skye', 'Cassin', 'm', '1982-07-11', '495 Hirthe Forges Apt. 052\nJuanamouth, MI 73793-8490', '3927210296', '1980-07-16', 'empower distributed supply-chains', 'Atque.', '74204 Michaela Bypass Suite 973\nLake Edgardo, UT 84688');
INSERT INTO `clients_passports` (`id_client`, `first_name`, `patronymic`, `last_name`, `gender`, `birthday`, `birth_place`, `passport_number`, `issue_date`, `issue_department`, `issue_department_code`, `place_of_residence`) VALUES (2, 'Jaydon', 'Jadon', 'Leffler', 'f', '1989-06-17', '8802 Haley Meadow Suite 975\nNew Abraham, TX 18851-9083', '4289460343', '2014-01-14', 'e-enable distributed convergence', 'Nemo.', '49181 Fanny Lane\nSouth Jadastad, ID 27055-4309');
INSERT INTO `clients_passports` (`id_client`, `first_name`, `patronymic`, `last_name`, `gender`, `birthday`, `birth_place`, `passport_number`, `issue_date`, `issue_department`, `issue_department_code`, `place_of_residence`) VALUES (3, 'Maude', 'Sonny', 'Nicolas', 'm', '1985-04-28', '84723 Rice Mill Suite 982\nWest Martinestad, TX 82792', '9163713112', '2018-05-04', 'aggregate extensible relationships', 'Et.', '0617 Alvena Dale\nLake Angiefort, ID 77871');
INSERT INTO `clients_passports` (`id_client`, `first_name`, `patronymic`, `last_name`, `gender`, `birthday`, `birth_place`, `passport_number`, `issue_date`, `issue_department`, `issue_department_code`, `place_of_residence`) VALUES (4, 'Holden', 'Vincent', 'Russel', 'f', '1994-12-05', '9237 Heidi View\nGonzalotown, SC 01501-9631', '8494945642', '2019-12-07', 'benchmark synergistic convergence', 'Qui.', '98637 Kiehn Flat Suite 746\nStiedemannmouth, LA 69118');
INSERT INTO `clients_passports` (`id_client`, `first_name`, `patronymic`, `last_name`, `gender`, `birthday`, `birth_place`, `passport_number`, `issue_date`, `issue_department`, `issue_department_code`, `place_of_residence`) VALUES (5, 'Preston', 'Mitchel', 'McClure', 'f', '1994-05-15', '102 Ciara Ville\nPort Sammy, PA 90795-2431', '8118941139', '1997-07-14', 'transition sexy paradigms', 'Vitae.', '227 Mohammed Ridges Suite 992\nNew Damon, UT 83882-0544');
INSERT INTO `clients_passports` (`id_client`, `first_name`, `patronymic`, `last_name`, `gender`, `birthday`, `birth_place`, `passport_number`, `issue_date`, `issue_department`, `issue_department_code`, `place_of_residence`) VALUES (6, 'Jess', 'Kyle', 'Kulas', 'm', '1992-03-01', '9420 Jerad Centers\nNew Buck, NY 43934-3417', '7444928715', '1970-03-19', 'incentivize clicks-and-mortar ROI', 'Qui.', '4766 Koch Way Suite 440\nEast Fidelstad, GA 92568-1813');
INSERT INTO `clients_passports` (`id_client`, `first_name`, `patronymic`, `last_name`, `gender`, `birthday`, `birth_place`, `passport_number`, `issue_date`, `issue_department`, `issue_department_code`, `place_of_residence`) VALUES (7, 'Carleton', 'Riley', 'Ryan', 'f', '1986-04-16', '863 Vivienne Fords\nRuntehaven, VA 94605', '1549596340', '1978-04-02', 'redefine robust users', 'Sint.', '3979 Crona Ramp\nNorth Calebchester, NJ 86141');
INSERT INTO `clients_passports` (`id_client`, `first_name`, `patronymic`, `last_name`, `gender`, `birthday`, `birth_place`, `passport_number`, `issue_date`, `issue_department`, `issue_department_code`, `place_of_residence`) VALUES (8, 'Kitty', 'Jean', 'Ledner', 'm', '1977-11-12', '44579 Norma Shoal Suite 582\nNorth Adonis, MD 39313-0626', '6475783457', '1982-06-14', 'synergize wireless supply-chains', 'Omnis.', '96503 Desmond Garden Apt. 535\nEast Florenciobury, AK 60602-7613');
INSERT INTO `clients_passports` (`id_client`, `first_name`, `patronymic`, `last_name`, `gender`, `birthday`, `birth_place`, `passport_number`, `issue_date`, `issue_department`, `issue_department_code`, `place_of_residence`) VALUES (9, 'Taylor', 'Ezra', 'Gaylord', 'f', '1980-12-31', '088 Waters Island\nVolkmanchester, TN 30026-1198', '5335135265', '2016-06-26', 'monetize interactive web-readiness', 'Eius.', '30199 Darrel Causeway Apt. 008\nMarinaton, NY 66411');
INSERT INTO `clients_passports` (`id_client`, `first_name`, `patronymic`, `last_name`, `gender`, `birthday`, `birth_place`, `passport_number`, `issue_date`, `issue_department`, `issue_department_code`, `place_of_residence`) VALUES (10, 'Darrell', 'Wilburn', 'Macejkovic', 'm', '1978-07-23', '93365 Ahmad Haven Apt. 583\nNorth Rosendo, KY 16701', '7730775472', '1982-06-16', 'exploit synergistic deliverables', 'Vel.', '086 Howell Meadows\nWest Efren, OR 65455');


#
# TABLE STRUCTURE FOR: clients_profiles
#

DROP TABLE IF EXISTS `clients_profiles`;

CREATE TABLE `clients_profiles` (
  `id_client` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(65) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_deleted` datetime DEFAULT NULL,
  `status` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `id_client_UNIQUE` (`id_client`),
  UNIQUE KEY `login_UNIQUE` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `clients_profiles` (`id_client`, `login`, `password_hash`, `date_created`, `date_deleted`, `status`) VALUES (1, 'mollitia', '6a00c5c9dcfa58e5c35ee9ccaf9f21a2f2710a4b', '2007-12-23 22:26:24', NULL, 'Active');
INSERT INTO `clients_profiles` (`id_client`, `login`, `password_hash`, `date_created`, `date_deleted`, `status`) VALUES (2, 'aut', '12027854a6beb3abb2518718cd30110a003ecf42', '2008-07-21 17:14:26', NULL, 'Active');
INSERT INTO `clients_profiles` (`id_client`, `login`, `password_hash`, `date_created`, `date_deleted`, `status`) VALUES (3, 'quasi', '10baa2a499d6377a39da25ae9740374e67452b59', '1980-08-06 04:08:00', NULL, 'Active');
INSERT INTO `clients_profiles` (`id_client`, `login`, `password_hash`, `date_created`, `date_deleted`, `status`) VALUES (4, 'adipisci', '26eb1b4dd583061ba1b09578b35f4e9269e73602', '1993-12-21 15:44:53', NULL, 'Active');
INSERT INTO `clients_profiles` (`id_client`, `login`, `password_hash`, `date_created`, `date_deleted`, `status`) VALUES (5, 'voluptas', 'b1d1669e4b994abf9108dcfe43d2de980ef28520', '1972-10-06 07:46:53', NULL, 'Active');
INSERT INTO `clients_profiles` (`id_client`, `login`, `password_hash`, `date_created`, `date_deleted`, `status`) VALUES (6, 'voluptatum', '3e42f9ab23b95d9e06b123e5a3d4b676e3896f57', '2004-06-11 06:25:28', NULL, 'Active');
INSERT INTO `clients_profiles` (`id_client`, `login`, `password_hash`, `date_created`, `date_deleted`, `status`) VALUES (7, 'minima', '69a541f2a97198eccda3c36fb33765d6c25a0a21', '2000-06-27 14:22:27', NULL, 'Active');
INSERT INTO `clients_profiles` (`id_client`, `login`, `password_hash`, `date_created`, `date_deleted`, `status`) VALUES (8, 'corrupti', '3b7e3da537e26685eaa91390eb1b2eac2b19cf11', '1987-09-15 11:18:00', NULL, 'Active');
INSERT INTO `clients_profiles` (`id_client`, `login`, `password_hash`, `date_created`, `date_deleted`, `status`) VALUES (9, 'sequi', 'f413b514724e5ab663aacf53c72db9a4901aa036', '2004-12-17 07:14:06', NULL, 'Active');
INSERT INTO `clients_profiles` (`id_client`, `login`, `password_hash`, `date_created`, `date_deleted`, `status`) VALUES (10, 'quisquam', '673a19b38c43006b678ac702bfd0839366fd76fe', '1976-10-13 18:46:47', NULL, 'Active');


#
# TABLE STRUCTURE FOR: clients_resume
#

DROP TABLE IF EXISTS `clients_resume`;

CREATE TABLE `clients_resume` (
  `id_client` int(10) unsigned NOT NULL,
  `rating` int(10) unsigned NOT NULL DEFAULT 10000,
  `family_client` tinyint(4) DEFAULT NULL,
  `salary_client` tinyint(4) DEFAULT NULL,
  `staff_client` tinyint(4) DEFAULT NULL,
  `id_advertisement_group` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `id_client_UNIQUE` (`id_client`),
  KEY `advertisement_group` (`id_advertisement_group`),
  CONSTRAINT `fk_table1_clients_profiles1` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `clients_resume` (`id_client`, `rating`, `family_client`, `salary_client`, `staff_client`, `id_advertisement_group`) VALUES (1, 10000, 1, 1, 0, 3);
INSERT INTO `clients_resume` (`id_client`, `rating`, `family_client`, `salary_client`, `staff_client`, `id_advertisement_group`) VALUES (2, 10000, 1, 1, 1, 1);
INSERT INTO `clients_resume` (`id_client`, `rating`, `family_client`, `salary_client`, `staff_client`, `id_advertisement_group`) VALUES (3, 10000, 0, 1, 1, 0);
INSERT INTO `clients_resume` (`id_client`, `rating`, `family_client`, `salary_client`, `staff_client`, `id_advertisement_group`) VALUES (4, 10000, 1, 0, 1, 1);
INSERT INTO `clients_resume` (`id_client`, `rating`, `family_client`, `salary_client`, `staff_client`, `id_advertisement_group`) VALUES (5, 10000, 0, 0, 1, 0);
INSERT INTO `clients_resume` (`id_client`, `rating`, `family_client`, `salary_client`, `staff_client`, `id_advertisement_group`) VALUES (6, 10000, 0, 0, 0, 2);
INSERT INTO `clients_resume` (`id_client`, `rating`, `family_client`, `salary_client`, `staff_client`, `id_advertisement_group`) VALUES (7, 10000, 0, 1, 0, 0);
INSERT INTO `clients_resume` (`id_client`, `rating`, `family_client`, `salary_client`, `staff_client`, `id_advertisement_group`) VALUES (8, 10000, 0, 0, 1, 3);
INSERT INTO `clients_resume` (`id_client`, `rating`, `family_client`, `salary_client`, `staff_client`, `id_advertisement_group`) VALUES (9, 10000, 0, 0, 1, 0);
INSERT INTO `clients_resume` (`id_client`, `rating`, `family_client`, `salary_client`, `staff_client`, `id_advertisement_group`) VALUES (10, 10000, 1, 1, 1, 1);


#
# TABLE STRUCTURE FOR: clients_sessions
#

DROP TABLE IF EXISTS `clients_sessions`;

CREATE TABLE `clients_sessions` (
  `id_clients_session` int(10) unsigned NOT NULL,
  `id_client` int(10) unsigned NOT NULL,
  `id_staff` int(10) unsigned DEFAULT NULL,
  `date_start` datetime NOT NULL DEFAULT current_timestamp(),
  `date_stop` datetime NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_type` int(10) unsigned DEFAULT NULL,
  `ip_v4` int(10) unsigned DEFAULT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_clients_session`),
  UNIQUE KEY `id_clients_session_UNIQUE` (`id_clients_session`),
  KEY `fk_clients_sessions_clients_profiles1_idx` (`id_client`),
  KEY `date_start` (`date_start`),
  KEY `date_stop` (`date_stop`),
  CONSTRAINT `fk_clients_sessions_clients_profiles1` FOREIGN KEY (`id_client`) REFERENCES `clients_profiles` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (1, 3, 10, '2004-05-02 03:10:28', '1993-03-02 22:54:51', '\'Visiting website\'', 4294967295, 4294967295, '138.326.6108');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (2, 7, 9, '1979-11-15 23:16:57', '1971-01-09 16:13:21', '\'Visiting website\'', 4294967295, 4294967295, '1-290-761-7472x57431');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (3, 10, 8, '1976-03-05 16:44:31', '1975-03-22 17:57:06', '\'Calling bank office', 1805439688, 4294967295, '577-181-4588');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (4, 8, 6, '1976-02-02 07:21:29', '2012-05-29 02:16:52', '\'ATM\'', 410492860, 4294967295, '1-645-994-4471x863');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (5, 2, 5, '2015-06-24 12:23:12', '2011-09-27 12:27:51', '\'ATM\'', 2966297897, 4294967295, '244.344.1064');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (6, 5, 10, '1989-06-23 06:10:50', '1989-07-23 12:31:55', '\'Mobile application\'', 4294967295, 4294967295, '(115)352-1672');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (7, 8, 1, '1973-06-18 22:49:41', '2020-03-02 18:17:14', '\'ATM\'', 4294967295, 2802061543, '161-348-0447x907');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (8, 4, 5, '2018-10-23 02:25:59', '1997-01-07 05:33:51', '\'Mobile application\'', 2901266441, 4294967295, '263.595.9115x88870');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (9, 6, 10, '1985-02-03 08:09:09', '1971-09-19 04:50:42', '\'Visiting bank offic', 4294967295, 2993051111, '(126)874-3562x16848');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (10, 1, 3, '1991-01-11 07:30:08', '1997-08-05 19:55:53', '\'ATM\'', 423851301, 4294967295, '1-424-135-6932x19382');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (11, 3, 2, '2017-08-15 22:04:23', '1970-07-06 19:45:55', '\'Visiting bank offic', 3485824817, 4294967295, '1-200-681-2123x0799');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (12, 1, 7, '1978-04-19 20:07:41', '1970-06-15 22:29:20', '\'Mobile application\'', 4294967295, 4294967295, '539-548-4187x4086');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (13, 7, 3, '1992-06-22 03:58:14', '1995-04-18 05:24:53', '\'Visiting website\'', 788594844, 4294967295, '+05(9)6291866931');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (14, 10, 9, '2011-07-12 13:43:31', '2011-03-24 08:47:46', '\'Mobile application\'', 1034558012, 4294967295, '553.139.9130');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (15, 6, 1, '2020-03-01 08:17:49', '1977-11-03 02:48:10', '\'Mobile application\'', 4294967295, 1342155431, '08010744385');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (16, 9, 5, '1975-08-20 01:34:53', '2009-10-02 20:58:44', '\'ATM\'', 177359075, 4294967295, '(779)726-2878x064');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (17, 2, 10, '1978-10-25 23:16:04', '1986-11-28 11:07:19', '\'Calling bank office', 2325598217, 2724190469, '1-321-382-7046');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (18, 9, 1, '2016-03-23 06:47:43', '2019-03-26 19:56:52', '\'Calling bank office', 4294967295, 3118151942, '011-500-7476x453');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (19, 5, 6, '2001-09-06 06:21:41', '1977-07-03 15:14:44', '\'ATM\'', 4294967295, 3755328245, '+94(5)6825890872');
INSERT INTO `clients_sessions` (`id_clients_session`, `id_client`, `id_staff`, `date_start`, `date_stop`, `type`, `id_type`, `ip_v4`, `phone_number`) VALUES (20, 4, 10, '2006-12-20 22:50:45', '1994-10-26 00:34:06', '\'Visiting bank offic', 1099077540, 4294967295, '+20(6)7997701640');


#
# TABLE STRUCTURE FOR: offers_credit
#

DROP TABLE IF EXISTS `offers_credit`;

CREATE TABLE `offers_credit` (
  `id_offer_credit` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `duration_max` smallint(4) unsigned NOT NULL,
  `duration_min` smallint(4) unsigned NOT NULL,
  `limit_min` decimal(12,2) unsigned NOT NULL,
  `limit_max` decimal(12,2) unsigned NOT NULL,
  `interest_rate` decimal(5,2) unsigned NOT NULL,
  `payment_period` smallint(4) unsigned NOT NULL,
  `insurance` decimal(12,2) unsigned NOT NULL DEFAULT 0.00,
  `name` varchar(65) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_start` datetime NOT NULL DEFAULT current_timestamp(),
  `date_stop` datetime DEFAULT NULL,
  `status` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_offer_credit`),
  UNIQUE KEY `id_offer_credit_UNIQUE` (`id_offer_credit`),
  KEY `duration_max` (`duration_max`),
  KEY `duration_min` (`duration_min`),
  KEY `limit_max` (`limit_max`),
  KEY `limit_min` (`limit_min`),
  KEY `interest_rate` (`interest_rate`),
  KEY `date_start` (`date_start`),
  KEY `date_stop` (`date_stop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

#
# TABLE STRUCTURE FOR: offers_debit
#

DROP TABLE IF EXISTS `offers_debit`;

CREATE TABLE `offers_debit` (
  `id_offer_debit` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `duration_min` smallint(4) unsigned NOT NULL,
  `duration_max` smallint(4) unsigned NOT NULL,
  `limit_min` decimal(12,2) unsigned NOT NULL,
  `limit_max` decimal(12,2) unsigned NOT NULL,
  `profitability` decimal(5,2) unsigned NOT NULL,
  `accrual_period` smallint(4) unsigned NOT NULL,
  `insurance` decimal(12,2) unsigned NOT NULL,
  `deposit` tinyint(4) NOT NULL DEFAULT 1,
  `withdraw` tinyint(4) NOT NULL DEFAULT 1,
  `name` varchar(65) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_start` datetime NOT NULL DEFAULT current_timestamp(),
  `date_stop` datetime DEFAULT NULL,
  `status` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_offer_debit`),
  UNIQUE KEY `id_offer_debit_UNIQUE` (`id_offer_debit`),
  KEY `duration_max` (`duration_max`),
  KEY `duration_min` (`duration_min`),
  KEY `limit_max` (`limit_max`),
  KEY `limit_min` (`limit_min`),
  KEY `profitability` (`profitability`),
  KEY `date_start` (`date_start`),
  KEY `date_stop` (`date_stop`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

