-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

-- CTE для формирования списка id самых молодых пользователей.
WITH t1 AS (
	SELECT p.user_id
	FROM profile AS p
    -- Сортировка пользователей по возрастанию их возраста
	ORDER BY p.birth_date DESC
	LIMIT 10
	)

SELECT COUNT(*) AS total_amount_of_likes
FROM like_user AS lu
WHERE lu.target_user_id IN (SELECT * FROM t1);

-- Решение с использованием JOIN

SELECT COUNT(t1.target_user_id) AS total_amount_likes
FROM (
	SELECT
		DENSE_RANK() OVER(ORDER BY p.birth_date DESC) AS dr,
		lu.target_user_id
	FROM profile AS p
		LEFT JOIN like_user AS lu ON lu.target_user_id = p.user_id
	) AS t1
WHERE t1.dr <= 10;
