INSERT INTO user (email, phone, password_hash)
VALUES	('email_2@mail.ru', 79000000002, sha1('email_2@mail.ru')),
		('email_3@mail.ru', 79000000003, sha1('email_3@mail.ru')),
        ('email_4@mail.ru', 79000000004, sha1('email_4@mail.ru'));

UPDATE user
SET deleted_date = NOW()
WHERE id = 2;

DELETE 
FROM user
WHERE deleted_date IS NULL
	AND id > 1;

SELECT *
FROM user;

ALTER TABLE user
AUTO_INCREMENT = 100;

INSERT INTO user
VALUES (default, 'test@email.com', 79001234567, sha1('123'), default, default);

TRUNCATE TABLE user;

SELECT *
FROM like_user;

DELETE
FROM user
WHERE id > 0;

ALTER TABLE user AUTO_INCREMENT = 1;

SELECT *
FROM post;

ALTER TABLE post
ADD COLUMN deleted_date DATETIME NULL DEFAULT NULL;