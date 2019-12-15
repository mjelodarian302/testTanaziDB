SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[DaysToDate] (@type SMALLINT, @year SMALLINT, @month SMALLINT, @day SMALLINT) 
RETURNS SMALLINT AS
BEGIN 
DECLARE @result SMALLINT
IF ( dbo.IsDateValid(@type, @year, @month, @day) = 1)
BEGIN
SET @result = dbo.DaysToMonth(@type, @month) + @day
IF ( (@month > dbo.LeapMonth(@type)) AND (dbo.IsLeapYear(@type, @year) = 1) )
SET @result = @result+1
END
ELSE
SET @result = 0
RETURN @result
END
GO
