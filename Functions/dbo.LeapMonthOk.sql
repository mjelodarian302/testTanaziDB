SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--select dbo.ToSolarOk( '1943/11/12')

---------------------------------------------------------------------------------------------
CREATE FUNCTION [dbo].[LeapMonthOk] (@type SMALLINT) 
RETURNS SMALLINT AS
BEGIN 
DECLARE @array VARCHAR(5)
DECLARE @result SMALLINT
SET @array = '12,02' -- esfand, february
SET @result = CAST(SUBSTRING(@array, @type*2+@type+1, 2) AS SMALLINT)
RETURN @result
END
GO
