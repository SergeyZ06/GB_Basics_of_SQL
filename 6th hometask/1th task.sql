-- 2. Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

-- Переменная для хранения id некоторого пользователя, друзей которого нужно найти.
SET @USER_ID := 6;

SELECT
	-- Так как запрос дружбы может быть либо создан самим пользователем, либо принят от другого пользователя,
    -- необходимо определить id друзей пользователя, которые отличны от id самого пользователя.
    IF(f.user_id = @USER_ID, f.target_user_id, f.user_id) AS user_friend_id,
    (
		SELECT COUNT(m.text) 
		FROM message AS m 
        WHERE 
			-- Среди всех сообщений нужно найти те, где искомый пользователь был либо отправителем, либо получателем сообщений.
			(m.from_user_id = @USER_ID OR m.to_user_id = @USER_ID)
            AND
            -- Для сопоставления строк нужно использовать id друзей пользователя, а не id самого пользователя.
            IF(m.from_user_id = @USER_ID, m.to_user_id, m.from_user_id) = IF(f.user_id = @USER_ID, f.target_user_id, f.user_id)
	) AS amount_of_messages
FROM friend_request AS f
WHERE
	f.status = 1
	AND
	(f.user_id = @USER_ID OR f.target_user_id = @USER_ID)
-- Сортировка пользователей по убыванию кол-ва их сообщений
ORDER BY amount_of_messages DESC
LIMIT 1;

-- Решение с использованием JOIN

SELECT
	IF(fr.user_id = @USER_ID, fr.target_user_id, fr.user_id) AS user_friend_id,
    COUNT(*) AS amount_of_messages
FROM friend_request AS fr
	INNER JOIN message AS m
		ON (m.from_user_id = fr.user_id AND m.to_user_id = fr.target_user_id)
		OR (m.to_user_id = fr.user_id AND m.from_user_id = fr.target_user_id)
WHERE
	(fr.user_id = @USER_ID OR fr.target_user_id = @USER_ID)
    AND
	fr.status = 1
GROUP BY IF(fr.user_id = @USER_ID, fr.target_user_id, fr.user_id)
ORDER BY amount_of_messages DESC
LIMIT 1;
