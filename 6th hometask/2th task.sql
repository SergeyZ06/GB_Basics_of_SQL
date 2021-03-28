-- 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

-- CTE для формирования списка id самых молодых пользователей.
WITH t1 AS (
	SELECT p.user_id
	FROM profile AS p
    -- Сортировка пользователей по возрастанию их возраста
	ORDER BY p.birth_date DESC
	LIMIT 10
	)

SELECT COUNT(total_list_of_likes.user_id) AS total_amount_of_likes
FROM (
	-- Поскольку данные о лайках хранятся в разных таблицах,
    -- необходимо получить полный список лайков.
	SELECT m.user_id
	FROM like_media AS m
    -- Учитывать лайки только от десяти самых молодых пользователей.
	WHERE m.user_id IN (SELECT * FROM t1)
	UNION ALL
	SELECT p.user_id
	FROM like_post AS p
	WHERE p.user_id IN (SELECT * FROM t1)
	UNION ALL
	SELECT u.user_id
	FROM like_user AS u
	WHERE u.user_id IN (SELECT * FROM t1)
	) total_list_of_likes;
