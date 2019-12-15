SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[DaysOfMonthOk] (@type SMALLINT, @year SMALLINT, @month SMALLINT) 
RETURNS SMALLINT AS
BEGIN 
DECLARE @result SMALLINT
IF ( (@year != 0) AND (@month >= 1 AND @month <= 12) )
BEGIN
SET @result = dbo.DaysOfMonthsOk(@type, @month)
IF ( (@month = dbo.LeapMonthOk(@type)) AND (dbo.IsLeapYearOk(@type, @year)=1) )
SET @result = @result+1
END 
ELSE
SET @result = 0

RETURN @result
END
GO
