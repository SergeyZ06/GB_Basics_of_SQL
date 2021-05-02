-- Скрипт формирования реалистичной даты проведения операции

SELECT * FROM banks_crm.clients_operations;

START TRANSACTION;

UPDATE banks_crm.clients_operations SET
	timestamp = (
		SELECT
			DATE_ADD(date_start, INTERVAL FLOOR(TIMESTAMPDIFF(SECOND, date_start, date_stop) * RAND()) SECOND)
		FROM banks_crm.clients_sessions
        WHERE banks_crm.clients_sessions.id_clients_session = banks_crm.clients_operations.id_clients_session
		);

COMMIT;
