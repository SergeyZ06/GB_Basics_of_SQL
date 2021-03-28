-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT
	u.id,
    -- Оценка степени активности пользователя по кол-ву поставленных лайков, коэффицент = 1
    (SELECT COUNT(*) FROM like_media AS m WHERE m.user_id = u.id) * 1 +
    (SELECT COUNT(*) FROM like_post AS p WHERE p.user_id = u.id) * 1 +
    (SELECT COUNT(*) FROM like_user AS u WHERE u.user_id = u.id) * 1 +
    -- Оценка степени активности пользователя по кол-ву отправленных сообщений, коэффицент = 10
    (SELECT COUNT(*) FROM message AS me WHERE me.from_user_id = u.id) * 10 +
    -- Оценка степени активности пользователя по кол-ву отправленных запросов в друзья, коэффицент = 20
    (SELECT COUNT(*) FROM friend_request AS f WHERE f.user_id = u.id) * 20 +
    -- Оценка степени активности пользователя по кол-ву принятых запросов в друзья, коэффицент = 10
    (SELECT COUNT(*) FROM friend_request AS f WHERE f.target_user_id = u.id AND f.status = 1) * 10 +
    -- Оценка степени активности пользователя по кол-ву написанных постов, коэффицент = 50
    (SELECT COUNT(*) FROM post AS po WHERE po.user_id = u.id) * 50 AS grade_of_activity
FROM user AS u
-- Сортировка пользователей по возрастанию коэффициента их активности
ORDER BY grade_of_activity ASC
LIMIT 10;
