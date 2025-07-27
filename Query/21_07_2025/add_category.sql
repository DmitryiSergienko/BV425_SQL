CREATE OR ALTER PROCEDURE add_category
	@name			NVARCHAR(200),
	@description	NVARCHAR(1000)
AS
BEGIN
	INSERT INTO categories (name, description) VALUES
	(@name, @description);
END

EXEC add_category N'���', N'��������� ���';

-- ��� �����������, ���� �����
SELECT * FROM categories;

-- ��� �������, ���� �����
DELETE FROM categories WHERE id = 6;