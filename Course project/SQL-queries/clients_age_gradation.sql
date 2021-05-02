-- Запрос для формирования градации возрастов клиентов
-- Запрос реализован как аналог отсутствующего в MySQL оператора PIVOT

SELECT
	'amount of clients' AS 'age gradation',
	SUM(IF(DATE_FORMAT(FROM_DAYS(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)), '%y') < 20, 1, 0)) AS '< 20',
    SUM(IF(DATE_FORMAT(FROM_DAYS(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)), '%y') BETWEEN 20 AND 24, 1, 0)) AS '20 - 24',
    SUM(IF(DATE_FORMAT(FROM_DAYS(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)), '%y') BETWEEN 25 AND 29, 1, 0)) AS '25 - 29',
    SUM(IF(DATE_FORMAT(FROM_DAYS(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)), '%y') BETWEEN 30 AND 34, 1, 0)) AS '30 - 34',
    SUM(IF(DATE_FORMAT(FROM_DAYS(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)), '%y') BETWEEN 35 AND 39, 1, 0)) AS '35 - 39',
    SUM(IF(DATE_FORMAT(FROM_DAYS(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)), '%y') BETWEEN 40 AND 44, 1, 0)) AS '40 - 44',
    SUM(IF(DATE_FORMAT(FROM_DAYS(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)), '%y') BETWEEN 45 AND 49, 1, 0)) AS '45 - 49',
    SUM(IF(DATE_FORMAT(FROM_DAYS(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)), '%y') BETWEEN 50 AND 54, 1, 0)) AS '50 - 54',
    SUM(IF(DATE_FORMAT(FROM_DAYS(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)), '%y') BETWEEN 55 AND 59, 1, 0)) AS '55 - 59',
    SUM(IF(DATE_FORMAT(FROM_DAYS(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)), '%y') BETWEEN 60 AND 64, 1, 0)) AS '60 - 64',
    SUM(IF(DATE_FORMAT(FROM_DAYS(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)), '%y') BETWEEN 65 AND 69, 1, 0)) AS '65 - 69',
    SUM(IF(DATE_FORMAT(FROM_DAYS(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)), '%y') BETWEEN 70 AND 74, 1, 0)) AS '70 - 74',
    SUM(IF(DATE_FORMAT(FROM_DAYS(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)), '%y') >= 75, 1, 0)) AS '>= 75'
FROM clients_passports AS cp
