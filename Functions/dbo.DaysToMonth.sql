SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[DaysToMonth] (@type SMALLINT, @month SMALLINT) 
RETURNS SMALLINT AS
BEGIN 
DECLARE @array_s VARCHAR(55) -- shamsi month days
DECLARE @array_g VARCHAR(55) -- gregorian month days
DECLARE @result SMALLINT
SET @array_s = '000,000,031,062,093,124,155,186,216,246,276,306,3 36,365'
SET @array_g = '000,000,031,059,090,120,151,181,212,243,273,304,3 34,365'
IF ( @type = 0 )
SET @result = CAST(SUBSTRING(@array_s, @month*3+@month+1, 3) AS SMALLINT)
ELSE
SET @result = CAST(SUBSTRING(@array_g, @month*3+@month+1, 3) AS SMALLINT)

RETURN @result
END
GO
