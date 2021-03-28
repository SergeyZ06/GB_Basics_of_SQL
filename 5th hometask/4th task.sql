-- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
-- Месяцы заданы в виде списка английских названий (may, august)

SELECT
	u.*,
    MONTHNAME((SELECT p.birth_date FROM profile AS p WHERE p.user_id = u.id)) AS birth_month
FROM user AS u
WHERE
	MONTHNAME((SELECT p.birth_date FROM profile AS p WHERE p.user_id = u.id)) = 'May'
    OR
    MONTHNAME((SELECT p.birth_date FROM profile AS p WHERE p.user_id = u.id)) = 'August';
