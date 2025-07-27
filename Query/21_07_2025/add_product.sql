CREATE OR ALTER PROCEDURE add_product
	@name			NVARCHAR(200),
	@description	NVARCHAR(1000),
	@price			DECIMAL(18,2)
AS
BEGIN
	INSERT INTO products (name, description, price) VALUES
	(@name, @description, @price);
END

EXEC add_product N'�����', N'����� ������� �����', 145.00;

-- ��� �����������, ���� �����
SELECT * FROM products;

-- ��� �������, ���� �����
DELETE FROM products WHERE id = 6;