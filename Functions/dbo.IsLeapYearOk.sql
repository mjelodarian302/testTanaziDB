SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[IsLeapYearOk] (@type SMALLINT, @year SMALLINT) 
RETURNS BIT AS
BEGIN 
DECLARE @result BIT
IF ( @type = 0 )
BEGIN
IF ( ((((@year + 38) * 31) % 128) <= 30) )
SET @result = 1
ELSE
SET @result = 0
END
ELSE
BEGIN
IF ( ((@year%4) = 0) and (((@year%100) != 0) or ((@year%400) = 0)) )
SET @result = 1
ELSE
SET @result = 0
END
RETURN @result
END
GO
