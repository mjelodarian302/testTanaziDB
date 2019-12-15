SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[SolarMonthOk] (@date DATETIME)
RETURNS SMALLINT AS
BEGIN
DECLARE @result SMALLINT
DECLARE @year SMALLINT
DECLARE @month SMALLINT
DECLARE @day SMALLINT
DECLARE @flag BIT
DECLARE @temp VARCHAR (10)
DECLARE @pos1 SMALLINT
DECLARE @pos2 SMALLINT
SET @result = 0
SET @year = DATEPART(yyyy, @date)
SET @month = DATEPART(mm, @date)
SET @day = DATEPART(dd, @date)
SET @temp = dbo.GregorianToSolarOk (@year, @month, @day)
IF ( @temp != 'ERROR' )
BEGIN
SET @pos1 = CHARINDEX('/', @temp)
SET @pos2 = CHARINDEX('/', @temp, @pos1+1)
SET @result = CAST(SUBSTRING(@temp, @pos1+1, @pos2-@pos1-1) AS SMALLINT) 
END
RETURN @result
END
GO
