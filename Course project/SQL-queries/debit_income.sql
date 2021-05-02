-- Запрос для формирования графика баланса дебетовых счетов после начисления процентов
-- Запрос реализован также в виде процедуры "debit_income"

WITH RECURSIVE t1 AS (
	SELECT
		ad.id_account_debit,
		ad.initial_balance,
		ad.date_start,
		ad.date_stop,
		od.accrual_period,
		ROUND(od.profitability * ad.modifier, 2) AS profitability
	FROM accounts_debit AS ad
		INNER JOIN offers_debit AS od ON od.id_offer_debit = ad.id_offer_debit
	WHERE od.profitability > 0
    UNION ALL
    SELECT
		t1.id_account_debit,
        t1.initial_balance + t1.initial_balance * t1.profitability / 100 / 12,
        DATE_ADD(t1.date_start, INTERVAL t1.accrual_period DAY),
        t1.date_stop,
        t1.accrual_period,
        t1.profitability
	FROM t1
	WHERE DATE_ADD(t1.date_start, INTERVAL t1.accrual_period DAY) <= t1.date_stop
	)

SELECT
	t1.id_account_debit,
    t1.date_start AS accrual_date,
    t1.initial_balance AS balance
FROM t1
ORDER BY
	t1.id_account_debit,
    t1.date_start,
    t1.initial_balance;
