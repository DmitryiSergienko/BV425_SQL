CREATE OR ALTER PROCEDURE add_user
	@login					NVARCHAR(50),
	@password				NVARCHAR(100),
	@name					NVARCHAR(100),
	@surname				NVARCHAR(100),
	@patronymic				NVARCHAR(100),
	@mail					NVARCHAR(255),
	@phone_number			NVARCHAR(20)
AS
BEGIN
	INSERT INTO users (login, password, name, surname, patronymic, mail, phone_number) VALUES
	(@login, HASHBYTES('SHA2_256', @password), @name, @surname, @patronymic, @mail, @phone_number);
END

EXEC add_user newuser, '12345678', N'Федор', N'Федоров', N'Федорович', 'newuser@mail.ru', '+79428328282';

-- Для отображения, если нужно
SELECT * FROM users;

-- Для очистки, если нужно
DELETE FROM users WHERE id = 6;