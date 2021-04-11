-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

-- Триггер, запрещающий одновременную встравку NULL значений при операции INSERT
DROP TRIGGER IF EXISTS `shop`.`products_BEFORE_INSERT`;

DELIMITER $$
USE `shop`$$
CREATE DEFINER=`SergeyZ06`@`%` TRIGGER `products_BEFORE_INSERT` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
	IF ISNULL(NEW.name) + ISNULL(NEW.description) = 2
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: name and description should not be simultaneously equal NULL';
    
    -- Ещё можно сделать присвоение значений строк, но тогда не будет понятно, что происходит
    -- THEN SET NEW.name = OLD.name;
    -- SET NEW.description = OLD.description;
    END IF;
END$$
DELIMITER ;

-- Триггер, запрещающий одновременную встравку NULL значений при операции UPDATE
DROP TRIGGER IF EXISTS `shop`.`products_BEFORE_UPDATE`;

DELIMITER $$
USE `shop`$$
CREATE DEFINER = CURRENT_USER TRIGGER `shop`.`products_BEFORE_UPDATE` BEFORE UPDATE ON `products` FOR EACH ROW
BEGIN
	IF ISNULL(NEW.name) + ISNULL(NEW.description) = 2
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: name and description should not be simultaneously equal NULL';
    END IF;
END$$
DELIMITER ;

-- Проверка работоспособности триггеров
START TRANSACTION;

SELECT *
FROM shop.products;

INSERT INTO shop.products (name, description)
VALUES (NULL, NULL);

UPDATE shop.products SET
	name = NULL,
    description = NULL;

ROLLBACK;
