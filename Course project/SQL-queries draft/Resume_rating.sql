-- Скрипт для формирования реалистичного рейтинга клиента

SELECT * FROM banks_crm.clients_resume;

START TRANSACTION;

UPDATE banks_crm.clients_resume SET
	rating = rating - 1000 + FLOOR(RAND() * 3000);

COMMIT;
