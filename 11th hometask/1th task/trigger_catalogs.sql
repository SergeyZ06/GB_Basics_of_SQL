CREATE DEFINER=`SergeyZ06`@`%` TRIGGER `catalogs_AFTER_INSERT` AFTER INSERT ON `catalogs` FOR EACH ROW BEGIN
	INSERT INTO `shop`.`logs` (`table`, `primary_key`, `name`, `datetime`)
		VALUES ('catalogs',
			NEW.id,
--				(SELECT `AUTO_INCREMENT`
--				FROM  INFORMATION_SCHEMA.TABLES
--				WHERE TABLE_SCHEMA = 'shop'
--				AND   TABLE_NAME   = 'catalogs'),
			NEW.name, NOW());
END
