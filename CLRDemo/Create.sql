USE [master]
GO

CREATE DATABASE [CSTruter] 

GO
-- sp_configure'clr enabled', 1
-- RECONFIGURE
-- GO

USE [CSTruter]

GO

CREATE TABLE [dbo].[friends](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[firstname] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[lastname] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_friends] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO

INSERT INTO friends(firstname, lastname) VALUES ('Julie', 'Truter')
INSERT INTO friends(firstname, lastname) VALUES ('Eugene', 'Stander')
INSERT INTO friends(firstname, lastname) VALUES ('Jacques', 'Brits')
INSERT INTO friends(firstname, lastname) VALUES ('Jason', 'Smith')
INSERT INTO friends(firstname, lastname) VALUES ('Alexander', 'Mehlhorn')
INSERT INTO friends(firstname, lastname) VALUES ('Roland', 'Cooper')
INSERT INTO friends(firstname, lastname) VALUES ('Loren', 'Stevens')
INSERT INTO friends(firstname, lastname) VALUES ('Andre', 'van Coller')
INSERT INTO friends(firstname, lastname) VALUES ('Wayne', 'Kleynhans')

GO

CREATE ASSEMBLY CLRDemos FROM 'C:\procs\CLRDemo.dll' WITH PERMISSION_SET = SAFE;
GO

CREATE FUNCTION TRIM
(
	@value NVARCHAR(MAX)
) 
RETURNS NVARCHAR (MAX)
AS 
EXTERNAL NAME [CLRDemos].[CSTruter.com.functions].[Trim]
GO
CREATE FUNCTION SPLIT
(
	@separator NVARCHAR(10),
	@value NVARCHAR(MAX)
) 
RETURNS TABLE(id INT, value NVARCHAR(MAX))
AS 
EXTERNAL NAME [CLRDemos].[CSTruter.com.functions].[Split]
GO
CREATE PROCEDURE viewFriends
AS EXTERNAL NAME [CLRDemos].[CSTruter.com.Procedures].[viewFriends]
GO
CREATE PROCEDURE getDayNames(@name AS NVARCHAR(10))
AS EXTERNAL NAME [CLRDemos].[CSTruter.com.Procedures].[getDayNames]
GO