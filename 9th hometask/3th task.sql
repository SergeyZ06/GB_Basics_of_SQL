-- 3. (по желанию) Пусть имеется таблица с календарным полем created_at.
-- В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04',
-- '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август,
-- выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

-- Рекурсивное CTE, выводит список всех дней августа 2018
WITH RECURSIVE t1 AS (
	SELECT CAST('2018-08-01' AS DATE) AS day_of_august
    UNION ALL
    SELECT DATE_ADD(t1.day_of_august, INTERVAL 1 DAY)
    FROM t1
    WHERE t1.day_of_august < LAST_DAY(CAST('2018-08-01' AS DATE))
	),

-- Таблица с исходными датами
t2 AS (
	SELECT CAST('2018-08-01' AS DATE) AS created_at
    UNION
    SELECT CAST('2018-08-04' AS DATE)
    UNION
    SELECT CAST('2018-08-16' AS DATE)
    UNION
    SELECT CAST('2018-08-17' AS DATE)
	)

SELECT
	t1.day_of_august,
    NOT ISNULL(t2.created_at) AS presence
FROM t1
	LEFT JOIN t2 ON t2.created_at = t1.day_of_august;
