-- Скрипт для формирования реалистичной даты регистрации в банке: дата выдачи паспорта + от 0 до 365 дней

SELECT * FROM banks_crm.clients_profiles;

SELECT FLOOR(RAND() * 365);

SELECT
	DATE_ADD(p.issue_date, INTERVAL FLOOR(RAND() * 365) DAY)
FROM banks_crm.clients_passports AS p;

START TRANSACTION;

UPDATE banks_crm.clients_profiles SET
	date_created = (
					SELECT
						DATE_ADD(DATE_ADD(p.issue_date, INTERVAL FLOOR(RAND() * 365) DAY), INTERVAL FLOOR(RAND() * 60 * 60 * 24)  SECOND)
					FROM banks_crm.clients_passports AS p
                    WHERE p.id_client = banks_crm.clients_profiles.id_client
					);

COMMIT;
