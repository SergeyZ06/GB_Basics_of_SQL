-- Скрипт для формирования реалистичной даты выдачи паспорта: дата рождения + 20 лет

SELECT * FROM banks_crm.clients_passports;

SELECT
	*,
    DATE_ADD(birthday, INTERVAL 20 YEAR)
FROM banks_crm.clients_passports;

START TRANSACTION;

UPDATE banks_crm.clients_passports SET
	issue_date = DATE_ADD(birthday, INTERVAL 20 YEAR);

COMMIT;
