-- 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса.
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

-- Таблица с исходными данными.
WITH catalogs AS (
	SELECT *
    FROM (
		SELECT 1 AS id
		UNION ALL
		SELECT 2
		UNION ALL
		SELECT 3
		UNION ALL
		SELECT 4
		UNION ALL
		SELECT 5
		) catalogs
	)

-- Запрос данных из исходной таблицы с сортировкой.
SELECT c.id
FROM catalogs AS c
WHERE c.id IN (5, 1, 2)
ORDER BY
		-- Если значение c.id равно 5, то сортировать строку в первой группе,
        -- далее по аналогии, значение 1 - вторая группа,
        -- значение 2 - третья группа.
		CASE c.id
			WHEN 5
			THEN 0
			WHEN 1
			THEN 1
			WHEN 2
			THEN 2
        END;
