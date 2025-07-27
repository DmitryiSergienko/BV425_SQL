CREATE OR ALTER PROCEDURE add_product_categories
	@product_id				INT,
	@category_id			INT
AS
BEGIN
	INSERT INTO product_categories (product_id, category_id) VALUES
	(@product_id, @category_id);
END

EXEC add_product_categories 6, 6;
	
-- Для отображения, если нужно
SELECT * FROM product_categories;

-- Для очистки, если нужно
DELETE FROM product_categories WHERE product_id = 6;