-- 2. Таблица users была неудачно спроектирована.
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10.
-- Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.

-- Добавление двух новых столбцов для безопасного переноса данных.
ALTER TABLE user
ADD COLUMN created_at_new DATETIME NULL DEFAULT NULL,
ADD COLUMN updated_at_new DATETIME NULL DEFAULT NULL;

-- Перенос данных в новые столбцы из неудачно спроектированных старых столбцов:
-- сперва происходит разбор строки формата '20.10.2017 8:10',
-- из неё формируется строка формата '2017-10-20 8:10:00',
-- затем строка преобразовывается в тип данных DATETIME и записывается в новые столбцы.
UPDATE user
SET
	created_at_new = CAST(
						CONCAT(
							REPLACE(REPLACE(REGEXP_SUBSTR(created_at, '[.][0-9]+[ ]'), '.', ''), ' ', ''),
							'-',
							REPLACE(REGEXP_SUBSTR(created_at, '[.][0-9]+[.]'), '.', ''),
							'-',
							REPLACE(REGEXP_SUBSTR(created_at, '^[0-9]+[.]'), '.', ''),
							REGEXP_SUBSTR(created_at, '[ ][0-9]+[:]'),
							REPLACE(REGEXP_SUBSTR(created_at, '[:][0-9]+'), ':', ''),
							':00'
							)
						AS DATETIME),
	updated_at_new = CAST(
						CONCAT(
							REPLACE(REPLACE(REGEXP_SUBSTR(updated_at, '[.][0-9]+[ ]'), '.', ''), ' ', ''),
							'-',
							REPLACE(REGEXP_SUBSTR(updated_at, '[.][0-9]+[.]'), '.', ''),
							'-',
							REPLACE(REGEXP_SUBSTR(updated_at, '^[0-9]+[.]'), '.', ''),
							REGEXP_SUBSTR(updated_at, '[ ][0-9]+[:]'),
							REPLACE(REGEXP_SUBSTR(updated_at, '[:][0-9]+'), ':', ''),
							':00'
							)
						AS DATETIME)
WHERE id > 0;

-- Удаление старых столбцов и переименование новых.
ALTER TABLE user
DROP COLUMN created_at,
DROP COLUMN updated_at,
RENAME COLUMN created_at_new TO created_at,
RENAME COLUMN updated_at_new TO updated_at;
