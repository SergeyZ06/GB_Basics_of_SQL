-- 4. Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT
	(SELECT p.gender FROM profile AS p WHERE p.user_id = total_list_of_likes.user_id) AS gender,
	COUNT(total_list_of_likes.user_id) AS total_amount_of_likes
FROM (
	-- Поскольку данные о лайках хранятся в разных таблицах,
    -- необходимо получить полный список лайков.
	SELECT m.user_id
	FROM like_media AS m
	UNION ALL
	SELECT p.user_id
	FROM like_post AS p
	UNION ALL
	SELECT u.user_id
	FROM like_user AS u
    ) total_list_of_likes
GROUP BY
	gender
HAVING
-- Без учёта пользователей не указавших пол.
	gender <> 'x'
-- Сортировка групп пользователей по убыванию кол-ва их лайков
ORDER BY total_amount_of_likes DESC
LIMIT 1;

-- Решение с использованием JOIN

SELECT
	p.gender,
	COUNT(DISTINCT p.user_id, lm.media_id) +
    COUNT(DISTINCT p.user_id, lp.post_id) +
    COUNT(DISTINCT p.user_id, lu.target_user_id)
    AS total_amount_of_likes
FROM profile AS p
	LEFT JOIN like_media AS lm ON lm.user_id = p.user_id
    LEFT JOIN like_post AS lp ON lp.user_id = p.user_id
    LEFT JOIN like_user AS lu ON lu.user_id = p.user_id
WHERE p.gender <> 'x'
GROUP BY p.gender
ORDER BY total_amount_of_likes DESC
LIMIT 1;
