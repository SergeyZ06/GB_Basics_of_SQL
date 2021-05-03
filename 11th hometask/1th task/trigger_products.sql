CREATE DEFINER=`SergeyZ06`@`%` TRIGGER `products_AFTER_INSERT` AFTER INSERT ON `products` FOR EACH ROW BEGIN
	INSERT INTO `shop`.`logs` (`table`, `primary_key`, `name`, `datetime`)
		VALUES ('products', 
				(SELECT `AUTO_INCREMENT`
				FROM  INFORMATION_SCHEMA.TABLES
				WHERE TABLE_SCHEMA = 'shop'
				AND   TABLE_NAME   = 'products'),
			NEW.name, NOW());
END
