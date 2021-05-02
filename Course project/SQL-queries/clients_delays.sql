-- Запрос для поиска клиентов банка с просрочками платежей по кредитным счетам:
-- 1. id клиента
-- 2. количество дней просроченных платежей
-- 3. средняя сумма просроченного платежа
-- 4. расчётное снижение рейтинга клиента
-- Запрос реализован также в виде представления "client_delays"

SELECT
	ac.id_client,
    COUNT(acs.timestamp) AS amount_days_with_delay,
    AVG(acs.amount_of_delay) AS average_amount_of_delay,
    FLOOR(COUNT(acs.timestamp) * AVG(SQRT(acs.amount_of_delay))) AS rating_decrease
FROM accounts_credit AS ac
    INNER JOIN accounts_credit_status AS acs ON acs.id_account_credit = ac.id_account_credit
WHERE acs.amount_of_delay > 0
GROUP BY ac.id_client;
