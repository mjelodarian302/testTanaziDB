SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[SolarYear] (@date DATETIME)
RETURNS SMALLINT AS
BEGIN
DECLARE @result SMALLINT
DECLARE @year SMALLINT
DECLARE @month SMALLINT
DECLARE @day SMALLINT
DECLARE @temp VARCHAR (10)
DECLARE @pos1 SMALLINT
SET @result = 0
SET @year = DATEPART(yyyy, @date)
SET @month = DATEPART(mm, @date)
SET @day = DATEPART(dd, @date)
SET @temp = dbo.GregorianToSolar (@year, @month, @day)
IF ( @temp != 'ERROR' )
BEGIN
SET @pos1 = CHARINDEX('/', @temp)
SET @result = CAST(LEFT(@temp, @pos1-1) AS SMALLINT)
END
RETURN @result
END
GO
