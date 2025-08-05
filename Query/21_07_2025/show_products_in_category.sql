CREATE OR ALTER PROCEDURE show_products_in_category
	@category_id	INT
AS
BEGIN
	SELECT p.* FROM products AS p
	JOIN product_categories AS pc ON pc.product_id = p.id
	JOIN categories AS c ON pc.category_id = c.id
	WHERE c.id = @category_id;
END;
GO

EXEC show_products_in_category 5;