-- Скрипт для коррекции данных о сессиях пользователей

SELECT * FROM banks_crm.clients_sessions;

SELECT
	*,
    CASE type
    WHEN "'Visiting website'"
    THEN "Visiting website"
    WHEN "'Calling bank office"
    THEN "Calling bank office"
    WHEN "'ATM'"
    THEN "ATM"
    WHEN "'Mobile application'"
    THEN "Mobile application"
    WHEN "'Visiting bank offic"
    THEN "Visiting bank office"
    END type_correction
FROM banks_crm.clients_sessions;

START TRANSACTION;

UPDATE banks_crm.clients_sessions SET
	type = (
	    CASE type
		WHEN "'Visiting website'"
		THEN "Visiting website"
		WHEN "'Calling bank office"
		THEN "Calling bank office"
		WHEN "'ATM'"
		THEN "ATM"
		WHEN "'Mobile application'"
		THEN "Mobile application"
		WHEN "'Visiting bank offic"
		THEN "Visiting bank office"
		END
		);

UPDATE banks_crm.clients_sessions SET
	phone_number = (
		CASE type
		WHEN "Calling bank office"
        THEN phone_number
        END
		);

UPDATE banks_crm.clients_sessions SET
	ip_v4 = (
		CASE type
        WHEN "Visiting website"
        THEN ip_v4
        WHEN "Mobile application"
        THEN ip_v4
        END
		);

UPDATE banks_crm.clients_sessions SET
	id_staff = (
		CASE
		WHEN type <> "ATM"
        THEN id_staff
        END
		);

UPDATE banks_crm.clients_sessions SET
	date_start = (
		SELECT
			DATE_ADD(banks_crm.clients_profiles.date_created, INTERVAL FLOOR(RAND() * 60 * 60 * 24 * 365 * 3) SECOND)
		FROM banks_crm.clients_profiles
        WHERE banks_crm.clients_profiles.id_client = banks_crm.clients_sessions.id_client
		);

UPDATE banks_crm.clients_sessions SET
	date_stop = DATE_ADD(date_start, INTERVAL FLOOR(RAND() * 60 * 30) SECOND);
                    
COMMIT;
