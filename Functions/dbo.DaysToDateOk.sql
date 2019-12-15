SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[DaysToDateOk] (@type SMALLINT, @year SMALLINT, @month SMALLINT, @day SMALLINT) 
RETURNS SMALLINT AS
BEGIN 
DECLARE @result SMALLINT
IF ( dbo.IsDateValidOk(@type, @year, @month, @day) = 1)
BEGIN
SET @result = dbo.DaysToMonthOk(@type, @month) + @day
IF ( (@month > dbo.LeapMonthOk(@type)) AND (dbo.IsLeapYearOk(@type, @year) = 1) )
SET @result = @result+1
END
ELSE
SET @result = 0
RETURN @result
END
GO
