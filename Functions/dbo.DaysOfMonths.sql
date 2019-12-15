SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[DaysOfMonths] (@type SMALLINT, @month SMALLINT) 
RETURNS SMALLINT AS
BEGIN 
DECLARE @array_s VARCHAR(38) -- shamsi month days
DECLARE @array_g VARCHAR(38) -- gregorian month days
DECLARE @result SMALLINT
SET @array_s = '00,31,31,31,31,31,31,30,30,30,30,30,29'
SET @array_g = '00,31,28,31,30,31,30,31,31,30,31,30,31'
IF ( @type = 0 )
SET @result = CAST(SUBSTRING(@array_s, @month*2+@month+1, 2) AS SMALLINT)
ELSE
SET @result = CAST(SUBSTRING(@array_g, @month*2+@month+1, 2) AS SMALLINT)

RETURN @result
END
GO
