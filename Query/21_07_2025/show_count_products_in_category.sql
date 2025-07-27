CREATE OR ALTER VIEW show_count_products_in_category AS
SELECT c.name, SUM(wp.quantity) AS count_products FROM categories AS c
JOIN product_categories AS pc ON pc.category_id = c.id
JOIN products AS p ON pc.product_id = p.id
JOIN warehouse_products AS wp ON wp.product_id = p.id
GROUP BY c.name;

SELECT * FROM show_count_products_in_category
ORDER BY count_products DESC;