-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT
	p.*,
    c.name
FROM products AS p
	INNER JOIN catalogs AS c ON c.id = p.catalog_id;
