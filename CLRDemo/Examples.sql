EXEC viewFriends
GO
EXEC getDayNames 'en-GB'
GO
EXEC getDayNames 'af-ZA'
GO

DECLARE @value VARCHAR(50)
SET @value = ' The quick red fox humps the lazy brown dog ';
SELECT dbo.trim(@value)

GO

DECLARE @value2 VARCHAR(50)
SET @value2 = 'a,b,c,d,e,f,g'
SELECT * FROM dbo.split(',', @value2)

GO