SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[GregorianToSolarOk] (@year SMALLINT, @month SMALLINT, @day SMALLINT)
RETURNS VARCHAR(10) AS
BEGIN
DECLARE @result VARCHAR(10)
DECLARE @leapday SMALLINT
DECLARE @days SMALLINT
DECLARE @prevgregorianleap BIT
SET @result = 'ERROR'
IF ( dbo.IsDateValidOk(1, @year, @month, @day) = 1 )
BEGIN
SET @prevgregorianleap = dbo.IsLeapYearOk(1, @year-1)
SET @days = dbo.DaysToDateOk(1, @year, @month, @day)
SET @year = @year - 622
IF ( dbo.IsLeapYearOk(0, @year) = 1 )
SET @leapday = 1
ELSE
SET @leapday = 0
IF ( (@prevgregorianleap = 1) AND (@leapday = 1) )
SET @days = @days + 287
ELSE
SET @days = @days + 286
IF ( @days > (365 + @leapday) )
BEGIN
SET @year = @year+1
SET @days = @days - (365 + @leapday)
END
--
-- EXEC dbo.DateOfDay 0, @days, @year, @month OUT, @day OUT, @result OUT
-- insert procedure body for converting procedure to function, for using in query
DECLARE @type SMALLINT
DECLARE @m SMALLINT
SET @type = 0
SET @leapday = 0
SET @month = 0
SET @day = 0
SET @m = 2
WHILE (@m <= 13)
BEGIN
IF ( (@m > dbo.LeapMonthOk(@type)) AND (dbo.IsLeapYearOk(@type, @year) = 1) )
SET @leapday = 1
IF ( @days <= (dbo.DaysToMonthOk(@type, @m) + @leapday) )
BEGIN
SET @month = @m - 1
IF ( @month <= dbo.LeapMonthOk(@type) ) 
SET @leapday = 0
SET @day = @days - (dbo.DaysToMonthOk(@type, @month) + @leapday)
BREAK
END
SET @m = @m+1
END
IF ( dbo.IsDateValidOk(@type, @year, @month, @day) = 1 )
SET @result = CAST(@year AS VARCHAR) + '/' + CAST(@month AS VARCHAR) + '/' + CAST(@day AS VARCHAR) 
-- End procedure
--
END
RETURN @result
END
GO
