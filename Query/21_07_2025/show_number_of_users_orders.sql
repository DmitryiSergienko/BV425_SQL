CREATE VIEW show_number_of_users_orders AS
SELECT u.login, COUNT(o.id) as count_orders FROM users AS u
JOIN orders AS o ON o.user_id = u.id
GROUP BY u.login;