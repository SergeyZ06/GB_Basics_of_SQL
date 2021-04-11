-- 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at.
-- Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.

-- CTE, где строки нумеруются в порядке их устревания
WITH t1 AS (
	SELECT
		u.id,
		u.created_at,
		ROW_NUMBER() OVER( ORDER BY u.created_at DESC ) AS rn
	FROM shop.users AS u
    ),

-- CTE, где представлены id всех строк, кроме пяти самых молодых
t2 AS (
	SELECT t1.id
	FROM t1
	WHERE t1.rn > 5
    )

DELETE FROM shop.users
WHERE shop.users.id IN (SELECT * FROM t2);
