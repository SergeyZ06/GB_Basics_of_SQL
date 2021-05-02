-- Запрос для формирования сводной информации об использовании продуктов банка

SELECT
	'credit' AS type,
	oc.id_offer_credit,
    oc.name,
    COUNT(*) AS total_usage,
    CONCAT(CAST((100 * COUNT(*) / (SELECT COUNT(id_account_credit) FROM accounts_credit)) AS CHAR), ' %') AS comparative_usage,
    CAST(AVG(ac.initial_credit) AS DECIMAL(12, 2)) AS average_deal_size,
    AVG(DATEDIFF(ac.date_stop, ac.date_start)) AS average_duration,
    CAST(AVG(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)) / 365.25 AS DECIMAL(8, 2)) AS average_client_age
FROM offers_credit AS oc
	LEFT JOIN accounts_credit AS ac ON ac.id_offer_credit = oc.id_offer_credit
    LEFT JOIN clients_passports AS cp ON cp.id_client = ac.id_client
GROUP BY
	type,
	oc.id_offer_credit,
    oc.name    
UNION ALL
SELECT
	'debit' AS type,
    od.id_offer_debit,
    od.name,
    COUNT(*),
    CONCAT(CAST((100 * COUNT(*) / (SELECT COUNT(id_account_debit) FROM accounts_debit)) AS CHAR), ' %'),
    CAST(AVG(ad.initial_balance) AS DECIMAL(12, 2)),
    AVG(DATEDIFF(ad.date_stop, ad.date_start)),
    CAST(AVG(DATEDIFF(CAST(NOW() AS DATE), cp.birthday)) / 365.25 AS DECIMAL(8, 2))
FROM offers_debit AS od
	LEFT JOIN accounts_debit AS ad ON ad.id_offer_debit = od.id_offer_debit
    LEFT JOIN clients_passports AS cp ON cp.id_client = ad.id_client
GROUP BY
	type,
    od.id_offer_debit,
    od.name;
