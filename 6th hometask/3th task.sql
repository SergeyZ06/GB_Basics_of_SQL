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
