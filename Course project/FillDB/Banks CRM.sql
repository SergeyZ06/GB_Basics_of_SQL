CREATE TABLE IF NOT EXISTS `clients_profiles` (
  `id_client` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NULL,
  `password_hash` VARCHAR(65) NULL,
  `date_created` DATETIME NOT NULL DEFAULT NOW(),
  `date_deleted` DATETIME NULL DEFAULT NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_client`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC),
  UNIQUE INDEX `id_client_UNIQUE` (`id_client` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `clients_passports` (
  `id_client` INT UNSIGNED NOT NULL,
  `first_name` VARCHAR(65) NOT NULL,
  `patronymic` VARCHAR(65) NOT NULL,
  `last_name` VARCHAR(65) NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `birthday` DATE NOT NULL,
  `birth_place` VARCHAR(255) NOT NULL,
  `passport_number` BIGINT(10) NOT NULL,
  `issue_date` DATE NOT NULL,
  `issue_department` VARCHAR(255) NOT NULL,
  `issue_department_code` CHAR(7) NOT NULL,
  `place_of_residence` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`id_client`),
  FULLTEXT INDEX `full_name` (`first_name`, `patronymic`, `last_name`),
  INDEX `passport_number` (`passport_number` ASC),
  UNIQUE INDEX `passport_number_UNIQUE` (`passport_number` ASC),
  UNIQUE INDEX `id_client_UNIQUE` (`id_client` ASC),
  CONSTRAINT `fk_clients_passports_clients_profiles`
    FOREIGN KEY (`id_client`)
    REFERENCES `clients_profiles` (`id_client`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `clients_resume` (
  `id_client` INT UNSIGNED NOT NULL,
  `rating` INT UNSIGNED NOT NULL DEFAULT 10000,
  `family_client` TINYINT NULL,
  `salary_client` TINYINT NULL,
  `staff_client` TINYINT NULL,
  `id_advertisement_group` INT UNSIGNED NULL,
  PRIMARY KEY (`id_client`),
  INDEX `advertisement_group` (`id_advertisement_group` ASC),
  UNIQUE INDEX `id_client_UNIQUE` (`id_client` ASC),
  CONSTRAINT `fk_table1_clients_profiles1`
    FOREIGN KEY (`id_client`)
    REFERENCES `clients_profiles` (`id_client`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `client_contacts` (
  `id_client` INT UNSIGNED NOT NULL,
  `phone_number` VARCHAR(20) NULL,
  `phone_number_additional` VARCHAR(20) NULL,
  `email` VARCHAR(255) NULL,
  `place_of_residence` VARCHAR(500) NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE INDEX `phone_number_UNIQUE` (`phone_number` ASC),
  UNIQUE INDEX `phone_number_additional_UNIQUE` (`phone_number_additional` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `id_client_UNIQUE` (`id_client` ASC),
  CONSTRAINT `fk_table1_clients_profiles2`
    FOREIGN KEY (`id_client`)
    REFERENCES `clients_profiles` (`id_client`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `client_social_networks` (
  `id_client` INT UNSIGNED NOT NULL,
  `url_social_network` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_client`, `url_social_network`),
  UNIQUE INDEX `url_social_network_UNIQUE` (`url_social_network` ASC),
  CONSTRAINT `fk_table1_clients_profiles3`
    FOREIGN KEY (`id_client`)
    REFERENCES `clients_profiles` (`id_client`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `offers_credit` (
  `id_offer_credit` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `duration_max` SMALLINT(4) UNSIGNED NOT NULL,
  `duration_min` SMALLINT(4) UNSIGNED NOT NULL,
  `limit_min` DECIMAL(12,2) UNSIGNED NOT NULL,
  `limit_max` DECIMAL(12,2) UNSIGNED NOT NULL,
  `interest_rate` DECIMAL(5,2) UNSIGNED NOT NULL,
  `payment_period` SMALLINT(4) UNSIGNED NOT NULL,
  `insurance` DECIMAL(12,2) UNSIGNED NOT NULL DEFAULT 0,
  `name` VARCHAR(65) NOT NULL,
  `date_start` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_stop` DATETIME NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_offer_credit`),
  INDEX `duration_max` (`duration_max` ASC),
  INDEX `duration_min` (`duration_min` ASC),
  INDEX `limit_max` (`limit_max` ASC),
  INDEX `limit_min` (`limit_min` ASC),
  INDEX `interest_rate` (`interest_rate` ASC),
  INDEX `date_start` (`date_start` ASC),
  INDEX `date_stop` (`date_stop` ASC),
  UNIQUE INDEX `id_offer_credit_UNIQUE` (`id_offer_credit` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `accounts_credit` (
  `id_account_credit` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_offer_credit` INT UNSIGNED NOT NULL,
  `id_client` INT UNSIGNED NOT NULL,
  `date_start` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_stop` DATETIME NOT NULL,
  `modifier` DECIMAL(5,2) NOT NULL DEFAULT 0,
  `account_number` BIGINT(20) UNSIGNED NOT NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_account_credit`),
  INDEX `fk_accounts_credit_offers_credit1_idx` (`id_offer_credit` ASC),
  INDEX `fk_accounts_credit_clients_profiles1_idx` (`id_client` ASC),
  UNIQUE INDEX `account_number_UNIQUE` (`account_number` ASC),
  INDEX `date_start` (`date_start` ASC),
  INDEX `date_stop` (`date_stop` ASC),
  UNIQUE INDEX `id_account_credit_UNIQUE` (`id_account_credit` ASC),
  CONSTRAINT `fk_accounts_credit_offers_credit1`
    FOREIGN KEY (`id_offer_credit`)
    REFERENCES `offers_credit` (`id_offer_credit`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_accounts_credit_clients_profiles1`
    FOREIGN KEY (`id_client`)
    REFERENCES `clients_profiles` (`id_client`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `accounts_credit_status` (
  `id_account_credit` INT UNSIGNED NOT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `debt` DECIMAL(12,2) UNSIGNED NOT NULL,
  `debt_interest` DECIMAL(12,2) UNSIGNED NOT NULL,
  `amount_of_delay` DECIMAL(12,2) UNSIGNED NOT NULL DEFAULT 0,
  INDEX `fk_accounts_credit_status_accounts_credit1_idx` (`id_account_credit` ASC),
  PRIMARY KEY (`id_account_credit`, `timestamp`),
  INDEX `debt` (`debt` ASC),
  INDEX `debt_interest` (`debt_interest` ASC),
  INDEX `amount_of_delay` (`amount_of_delay` ASC),
  INDEX `timestamp` (`timestamp` ASC),
  CONSTRAINT `fk_accounts_credit_status_accounts_credit1`
    FOREIGN KEY (`id_account_credit`)
    REFERENCES `accounts_credit` (`id_account_credit`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `offers_debit` (
  `id_offer_debit` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `duration_min` SMALLINT(4) UNSIGNED NOT NULL,
  `duration_max` SMALLINT(4) UNSIGNED NOT NULL,
  `limit_min` DECIMAL(12,2) UNSIGNED NOT NULL,
  `limit_max` DECIMAL(12,2) UNSIGNED NOT NULL,
  `profitability` DECIMAL(5,2) UNSIGNED NOT NULL,
  `accrual_period` SMALLINT(4) UNSIGNED NOT NULL,
  `insurance` DECIMAL(12,2) UNSIGNED NOT NULL,
  `deposit` TINYINT NOT NULL DEFAULT 1,
  `withdraw` TINYINT NOT NULL DEFAULT 1,
  `name` VARCHAR(65) NOT NULL,
  `date_start` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_stop` DATETIME NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_offer_debit`),
  INDEX `duration_max` (`duration_max` ASC),
  INDEX `duration_min` (`duration_min` ASC),
  INDEX `limit_max` (`limit_max` ASC),
  INDEX `limit_min` (`limit_min` ASC),
  INDEX `profitability` (`profitability` ASC),
  INDEX `date_start` (`date_start` ASC),
  INDEX `date_stop` (`date_stop` ASC),
  UNIQUE INDEX `id_offer_debit_UNIQUE` (`id_offer_debit` ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `accounts_debit` (
  `id_account_debit` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_offer_debit` INT UNSIGNED NOT NULL,
  `id_client` INT UNSIGNED NOT NULL,
  `date_start` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_stop` DATETIME NULL,
  `modifier` DECIMAL(5,2) UNSIGNED NOT NULL DEFAULT 0,
  `account_number` BIGINT(20) UNSIGNED NOT NULL,
  `status` VARCHAR(45) NOT NULL DEFAULT 'Active',
  PRIMARY KEY (`id_account_debit`),
  INDEX `fk_accounts_debit_offers_debit1_idx` (`id_offer_debit` ASC),
  INDEX `fk_accounts_debit_clients_profiles1_idx` (`id_client` ASC),
  UNIQUE INDEX `account_number_UNIQUE` (`account_number` ASC),
  INDEX `date_start` (`date_start` ASC),
  INDEX `date_stop` (`date_stop` ASC),
  UNIQUE INDEX `id_account_debit_UNIQUE` (`id_account_debit` ASC),
  CONSTRAINT `fk_accounts_debit_offers_debit1`
    FOREIGN KEY (`id_offer_debit`)
    REFERENCES `offers_debit` (`id_offer_debit`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_accounts_debit_clients_profiles1`
    FOREIGN KEY (`id_client`)
    REFERENCES `clients_profiles` (`id_client`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `account_debit_status` (
  `accounts_debit_id_account_debit` INT UNSIGNED NOT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `balance` DECIMAL(12,2) NULL,
  INDEX `fk_table1_accounts_debit1_idx` (`accounts_debit_id_account_debit` ASC),
  PRIMARY KEY (`accounts_debit_id_account_debit`, `timestamp`),
  INDEX `balance` (`balance` ASC),
  INDEX `timestamp` (`timestamp` ASC),
  CONSTRAINT `fk_table1_accounts_debit1`
    FOREIGN KEY (`accounts_debit_id_account_debit`)
    REFERENCES `accounts_debit` (`id_account_debit`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `clients_sessions` (
  `id_clients_session` INT UNSIGNED NOT NULL,
  `id_client` INT UNSIGNED NOT NULL,
  `id_staff` INT UNSIGNED NULL,
  `date_start` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_stop` DATETIME NOT NULL,
  `type` VARCHAR(20) NOT NULL,
  `id_type` INT UNSIGNED NULL,
  `ip_v4` INT UNSIGNED NULL,
  `phone_number` VARCHAR(20) NULL,
  PRIMARY KEY (`id_clients_session`),
  INDEX `fk_clients_sessions_clients_profiles1_idx` (`id_client` ASC),
  INDEX `date_start` (`date_start` ASC),
  INDEX `date_stop` (`date_stop` ASC),
  UNIQUE INDEX `id_clients_session_UNIQUE` (`id_clients_session` ASC),
  CONSTRAINT `fk_clients_sessions_clients_profiles1`
    FOREIGN KEY (`id_client`)
    REFERENCES `clients_profiles` (`id_client`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `clients_operations` (
  `id_clients_operation` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_clients_session` INT UNSIGNED NOT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `amount_of_money` DECIMAL(12,2) UNSIGNED NOT NULL,
  `account_number_from` BIGINT(20) UNSIGNED NOT NULL,
  `account_number_to` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_clients_operation`),
  INDEX `fk_clients_operations_clients_sessions1_idx` (`id_clients_session` ASC),
  INDEX `timestamp` (`timestamp` ASC),
  INDEX `amount_of_money` (`amount_of_money` ASC),
  UNIQUE INDEX `id_clients_operation_UNIQUE` (`id_clients_operation` ASC),
  CONSTRAINT `fk_clients_operations_clients_sessions1`
    FOREIGN KEY (`id_clients_session`)
    REFERENCES `clients_sessions` (`id_clients_session`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;
