SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[SolarToGregorian] (@year SMALLINT, @month SMALLINT, @day SMALLINT)
RETURNS DATETIME AS
BEGIN
DECLARE @result DATETIME
DECLARE @leapday SMALLINT
DECLARE @days SMALLINT
DECLARE @prevsolarleap BIT
SET @result = 0 -- Jan 1 1900 12:00AM
IF ( dbo.IsDateValid(0, @year, @month, @day) = 1 )
BEGIN
SET @prevsolarleap= dbo.IsLeapYear(0, @year-1)
SET @days = dbo.DaysToDate(0, @year, @month, @day)
SET @year = @year + 621
IF ( dbo.IsLeapYear(1, @year) = 1 )
SET @leapday = 1
ELSE
SET @leapday = 0
IF ( (@prevsolarleap = 1) AND (@leapday = 1) )
SET @days = @days + 80
ELSE
SET @days = @days + 79
IF ( @days > (365 + @leapday) )
BEGIN
SET @year = @year+1
SET @days = @days - (365 + @leapday)
END
-- EXEC dbo.DateOfDay 1, @days, @year, @month OUT, @day OUT, @result OUT
-- insert procedure body for converting procedure to function, for using in query
DECLARE @type SMALLINT
DECLARE @temp VARCHAR(10)
DECLARE @m SMALLINT
SET @type = 1 
SET @leapday = 0
SET @month = 0
SET @day = 0
SET @m = 2
WHILE (@m <= 13)
BEGIN
IF ( (@m > dbo.LeapMonth(@type)) AND (dbo.IsLeapYear(@type, @year) = 1) )
SET @leapday = 1
IF ( @days <= (dbo.DaysToMonth(@type, @m) + @leapday) )
BEGIN
SET @month = @m - 1
IF ( @month <= dbo.LeapMonth(@type) ) 
SET @leapday = 0
SET @day = @days - (dbo.DaysToMonth(@type, @month) + @leapday)
BREAK
END
SET @m = @m+1
END
IF ( dbo.IsDateValid(@type, @year, @month, @day) = 1 )
BEGIN
SET @temp = CAST(@year AS VARCHAR) + '/' + CAST(@month AS VARCHAR) + '/' + CAST(@day AS VARCHAR)
SET @result = CAST(@temp AS DATETIME) 
END
-- End procedure
--
END
RETURN @result
END
GO
