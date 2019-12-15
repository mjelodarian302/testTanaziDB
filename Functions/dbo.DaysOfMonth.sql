SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[DaysOfMonth] (@type SMALLINT, @year SMALLINT, @month SMALLINT) 
RETURNS SMALLINT AS
BEGIN 
DECLARE @result SMALLINT
IF ( (@year != 0) AND (@month >= 1 AND @month <= 12) )
BEGIN
SET @result = dbo.DaysOfMonths(@type, @month)
IF ( (@month = dbo.LeapMonth(@type)) AND (dbo.IsLeapYear(@type, @year)=1) )
SET @result = @result+1
END 
ELSE
SET @result = 0

RETURN @result
END
GO
