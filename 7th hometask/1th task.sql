-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT *
FROM users AS u
WHERE EXISTS (SELECT 1 FROM orders AS o WHERE o.user_id = u.id);
