SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[IsDateValid] (@type SMALLINT, @year SMALLINT, @month SMALLINT, @day SMALLINT) 
RETURNS BIT AS
BEGIN 
DECLARE @result BIT
IF ( (@year != 0) AND (@month >= 1) AND (@month <= 12) AND
(@day >= 1) AND (@day <= dbo.DaysOfMonth(@type, @year, @month)) )
SET @result = 1
ELSE
SET @result = 0
RETURN @result
END
GO
