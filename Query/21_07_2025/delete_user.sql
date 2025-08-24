CREATE OR ALTER PROCEDURE [dbo].[stp_user_delete] 
    @id INT
AS
BEGIN
    DELETE FROM users 
    WHERE id = @id;  -- Предполагается, что столбец с ID называется 'id'
END
GO