CREATE OR ALTER PROCEDURE add_user
	@login					NVARCHAR(50),
	@password				NVARCHAR(100),
	@name					NVARCHAR(100),
	@surname				NVARCHAR(100),
	@patronymic				NVARCHAR(100),
	@mail					NVARCHAR(255),
	@phone_number			NVARCHAR(20),
	@new_id					INT OUTPUT
AS
BEGIN
	INSERT INTO users (login, password, name, surname, patronymic, mail, phone_number) VALUES
	(@login, @password, @name, @surname, @patronymic, @mail, @phone_number);

	SET @new_id = SCOPE_IDENTITY();
END

DECLARE @new_id INT;

EXEC add_user 
	@login = 'newuser',
    @password = '12345678',
    @name = N'�����',
    @surname = N'�������',
    @patronymic = N'���������',
    @mail = 'newuser@mail.ru',
    @phone_number = '+79428328282',
	@new_id = @new_id OUTPUT;

-- ��� �����������, ���� �����
SELECT * FROM users;

-- ��� �������, ���� �����
DELETE FROM users WHERE id >= 7;