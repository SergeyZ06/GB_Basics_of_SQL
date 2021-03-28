-- 1. Подсчитайте средний возраст пользователей в таблице users.

SELECT
	AVG(TIMESTAMPDIFF(YEAR, (SELECT p.birth_date FROM profile AS p WHERE p.user_id = u.id), CAST(NOW() AS DATE))) AS avg_age
FROM user AS u;
