-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

-- В теории это должно работать, но по факту MySQL сервер падает после ~200000 записей.
-- Auto Increment стал равен 196616, после этого произошла ошибка "Error Code: 2013. Lost connection to MySQL server during query".

SET @@CTE_MAX_RECURSION_DEPTH = 1000000;

INSERT INTO `users` (`name`) 
	WITH RECURSIVE t1 AS (
		SELECT 1 AS a
		UNION ALL
		SELECT a + 1
		FROM t1
		WHERE a < 1000000
		)
	SELECT CONCAT('test_user_', t1.a)
	FROM t1;

SELECT * FROM shop.users;
