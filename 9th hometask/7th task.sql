-- 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
-- Вызов функции FIBONACCI(10) должен возвращать число 55.

USE `shop`;
DROP function IF EXISTS `Fibonacci`;

USE `shop`;
DROP function IF EXISTS `shop`.`Fibonacci`;
;

DELIMITER $$
USE `shop`$$
CREATE DEFINER=`SergeyZ06`@`%` FUNCTION `Fibonacci`(variable INT) RETURNS int
    DETERMINISTIC
BEGIN
	IF variable <= 0
    THEN SET variable = 0;
    ELSEIF variable = 1
    THEN SET variable = 1;
    ELSEIF variable > 1
    THEN
        WITH RECURSIVE t1 AS (
		SELECT
			1 AS number1,
            2 AS i,
            1 AS prev1
        UNION ALL
        SELECT
			t1.number1 + t1.prev1,
            i + 1,
            t1.number1
		FROM t1
        WHERE t1.i < variable
        )
        
        SELECT MAX(t1.number1) INTO variable
        FROM t1;
    END IF;
    
RETURN variable;
END$$

DELIMITER ;
;

SELECT Fibonacci(10);
