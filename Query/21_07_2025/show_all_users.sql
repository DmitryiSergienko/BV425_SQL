CREATE OR ALTER PROCEDURE [dbo].[stp_users_all]
AS
BEGIN
SELECT * FROM users;
END

EXEC [dbo].[stp_users_all];