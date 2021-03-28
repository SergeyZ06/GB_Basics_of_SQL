-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
-- 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом,
-- чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех 

-- Таблица с исходными данными.
WITH t1 AS (
	SELECT *
	FROM (
		SELECT 0 AS value
		UNION ALL
		SELECT 2500 AS value
		UNION ALL
		SELECT 0 AS value
		UNION ALL
		SELECT 30 AS value
		UNION ALL
		SELECT 500 AS value
		UNION ALL
		SELECT 1 AS value
        ) AS t0
	)

-- Запрос данных из исходной таблицы с сортировкой по двум столбцам.
SELECT t1.value
FROM t1
ORDER BY
	-- Если значение t1.value равно 0, то сортировать строку во второй группе, иначе - в первой.
	IF(t1.value = 0, 1, 0),
    t1.value;
