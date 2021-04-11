-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;

INSERT INTO sample.users (
	sample.users.name,
    sample.users.birthday_at,
    sample.users.created_at,
    sample.users.updated_at    
    )
	SELECT
		u.name,
		u.birthday_at,
		u.created_at,
		u.updated_at
	FROM shop.users AS u
	WHERE u.id = 1;

DELETE FROM shop.users
WHERE shop.users.id = 1;

COMMIT;
