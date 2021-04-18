-- Скрипт для формирования реалистичного кода подразделения: от 100-100 до 999-999

SELECT * FROM banks_crm.clients_passports;

SELECT CONCAT(CAST(1000 - FLOOR(RAND() * 900) AS CHAR(3)), '-', CAST(1000 - FLOOR(RAND() * 900) AS CHAR(3)));

SELECT CAST(1000 - FLOOR(RAND() * 900) AS CHAR(3));

START TRANSACTION;

UPDATE banks_crm.clients_passports SET
	issue_department_code = CONCAT(CAST(999 - FLOOR(RAND() * 899) AS CHAR(3)), '-', CAST(999 - FLOOR(RAND() * 899) AS CHAR(3)));

COMMIT;
