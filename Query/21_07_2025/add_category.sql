CREATE OR ALTER PROCEDURE add_category
	@name			NVARCHAR(200),
	@description	NVARCHAR(1000)
AS
BEGIN
	INSERT INTO categories (name, description) VALUES
	(@name, @description);
END

EXEC add_category N'Еда', N'Съедобная еда';

-- Для отображения, если нужно
SELECT * FROM categories;

-- Для очистки, если нужно
DELETE FROM categories WHERE id = 6;