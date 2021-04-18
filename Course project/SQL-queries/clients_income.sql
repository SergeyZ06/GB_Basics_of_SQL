-- Запрос для поиска зарплатных семейных клиентов, имеющих средний доход выше прожиточного минимума
-- 1. id клиента
-- 2. средний доход клиента
-- Запрос реализован также ввиде представления "clients_income"

-- CTE для вывода операций зачисления средств на дебетовые счета клиентов
WITH t1 AS (
	SELECT
		ad.id_client,
        ads.id_operation,
        ads.balance,
        -- баланс счёта до выполнения текущей операции
		LAG(ads.balance, 1, 0) OVER(ORDER BY ads.timestamp) AS before_salary
	FROM accounts_debit AS ad
		INNER JOIN accounts_debit_status AS ads ON ads.id_account_debit = ad.id_account_debit
	)

SELECT
	t1.id_client,
    AVG(t1.balance - t1.before_salary) AS avg_income
FROM t1
-- отбор операций зачисления средств, код операции зачисления начинается с числа '3'
WHERE CAST(t1.id_operation AS CHAR) LIKE '3%'
	AND EXISTS(
		-- отбор клиентов удовлетворяющих кретериям: зарплатный клиент, семейный клиент
		SELECT 'test'
		FROM clients_resume AS cr
        WHERE cr.id_client = t1.id_client
			AND cr.family_client = TRUE
			AND cr.salary_client = TRUE
        )
GROUP BY t1.id_client
HAVING avg_income > 25000;
