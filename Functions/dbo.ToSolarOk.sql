SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[ToSolarOk] (@date DATETIME)
RETURNS VARCHAR(10) AS
BEGIN
DECLARE @result VARCHAR(10)
DECLARE @year SMALLINT
DECLARE @month SMALLINT
DECLARE @day SMALLINT
DECLARE @flag BIT
SET @year = DATEPART(yyyy, @date)
SET @month = DATEPART(mm, @date)
SET @day = DATEPART(dd, @date)
RETURN dbo.GregorianToSolarOk (@year, @month, @day)
END
GO