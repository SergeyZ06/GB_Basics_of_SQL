CREATE DEFINER=`SergeyZ06`@`%` TRIGGER `users_AFTER_INSERT` AFTER INSERT ON `users` FOR EACH ROW BEGIN
	INSERT INTO `shop`.`logs` (`table`, `primary_key`, `name`, `datetime`)
		VALUES ('users', 
				(SELECT `AUTO_INCREMENT`
				FROM  INFORMATION_SCHEMA.TABLES
				WHERE TABLE_SCHEMA = 'shop'
				AND   TABLE_NAME   = 'users'),
			NEW.name, NOW());
END
