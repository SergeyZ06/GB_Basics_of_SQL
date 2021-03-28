-- 3. (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское.
-- Выведите список рейсов flights с русскими названиями городов.

-- CTE для формирования списка рейсов.
WITH flights AS (
	SELECT 1 AS id, 'moscow' AS 'from', 'omsk' AS 'to'
	UNION ALL
	SELECT 2 AS id, 'novgorod', 'kazan'
	UNION ALL
	SELECT 3 AS id, 'irkutsk', 'moscow'
	UNION ALL
	SELECT 4 AS id, 'omsk', 'irkutsk'
	UNION ALL
	SELECT 5 AS id, 'moscow', 'kazan'
    ),

-- CTE для формирования списка городов.
cities AS (
	SELECT 'moscow' AS label, 'Москва' AS 'name'
	UNION ALL
	SELECT 'irkutsk', 'Иркутск'
	UNION ALL
	SELECT 'novgorod', 'Новгород'
	UNION ALL
	SELECT 'kazan', 'Казань'
	UNION ALL
	SELECT 'omsk', 'Омск'
	)

SELECT
	f.id,
    -- Использовать название города из таблицы cities,
    -- в случае его отсутствия использовать название из таблицы flights.
	COALESCE(c_from.name, f.from) AS 'from',
    COALESCE(c_to.name, f.to) AS 'to'
FROM flights AS f
	-- Левое соединение таблиц для исключения пропадания записей таблицы flights
    -- в случае отсутствия соотвествующих названий городов в таблице cities.
	LEFT JOIN cities AS c_from ON c_from.label = f.from
    LEFT JOIN cities AS c_to ON c_to.label = f.to;
