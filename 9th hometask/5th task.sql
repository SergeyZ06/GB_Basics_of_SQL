-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

USE `shop`;
DROP function IF EXISTS `hello`;

USE `shop`;
DROP function IF EXISTS `shop`.`hello`;
;

DELIMITER $$
USE `shop`$$
CREATE DEFINER=`SergeyZ06`@`%` FUNCTION `hello`() RETURNS varchar(20) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
	DECLARE message VARCHAR(20);
	
    SET message = CASE
		WHEN CAST(NOW() AS TIME) >= CAST('00:00:00' AS TIME) AND CAST(NOW() AS TIME) < CAST('06:00:00' AS TIME)
		THEN 'Доброй ночи'
		WHEN CAST(NOW() AS TIME) >= CAST('06:00:00' AS TIME) AND CAST(NOW() AS TIME) < CAST('12:00:00' AS TIME)
		THEN 'Доброе утро'
		WHEN CAST(NOW() AS TIME) >= CAST('12:00:00' AS TIME) AND CAST(NOW() AS TIME) < CAST('18:00:00' AS TIME)
		THEN 'Добрый день'
		WHEN CAST(NOW() AS TIME) >= CAST('18:00:00' AS TIME) AND CAST(NOW() AS TIME) < CAST('24:00:00' AS TIME)
		THEN 'Добрый вечер'
		END;

RETURN message;
END$$

DELIMITER ;
;

