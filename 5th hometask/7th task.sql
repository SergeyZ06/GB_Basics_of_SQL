-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT
    DAYNAME(CAST(DATE_FORMAT(p.birth_date, '2021-%m-%d') AS DATE)) AS day_of_week,
    COUNT(p.birth_date) AS amount_of_birthdays
FROM profile AS p
GROUP BY
	DAYNAME(CAST(DATE_FORMAT(p.birth_date, '2021-%m-%d') AS DATE))
ORDER BY
	WEEKDAY(CAST(DATE_FORMAT(p.birth_date, '2021-%m-%d') AS DATE));
