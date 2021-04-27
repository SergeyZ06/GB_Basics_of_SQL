CREATE DEFINER=`SergeyZ06`@`%` TRIGGER `products_BEFORE_INSERT` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
	IF ISNULL(NEW.name) + ISNULL(NEW.description) = 2
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: name and description should not be simultaneously equal NULL';
    END IF;
    
	INSERT INTO `shop`.`logs` (`table`, `primary_key`, `name`, `datetime`)
		VALUES ('products', 
				(SELECT `AUTO_INCREMENT`
				FROM  INFORMATION_SCHEMA.TABLES
				WHERE TABLE_SCHEMA = 'shop'
				AND   TABLE_NAME   = 'products'),
			NEW.name, NOW());
END
