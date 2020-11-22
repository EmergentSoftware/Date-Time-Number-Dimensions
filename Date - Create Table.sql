/* Can create a table to store work days off
CREATE TABLE Integration.WorkDayOff
(
	DayOff DATE NOT NULL
	,CONSTRAINT DayOff PRIMARY KEY CLUSTERED (DayOff ASC)
)
GO
*/

CREATE TABLE Dimension.Date (
    [Date Key]              INT          NOT NULL
   ,[Full Date Time]        DATETIME2(7) NOT NULL
   ,[Date Name]             VARCHAR(10)   NOT NULL
   ,[Date Name US]          VARCHAR(10)   NOT NULL
   ,[Date Name EU]          VARCHAR(10)   NOT NULL
   ,[Day Of Week]           TINYINT      NOT NULL
   ,[Day Name Of Week]      VARCHAR(9)   NOT NULL
   ,[Day Of Month]          TINYINT      NOT NULL
   ,[Day Of Year]           SMALLINT     NOT NULL
   ,[Weekday Weekend]       CHAR(7)      NOT NULL
   ,[Week Of Year]          TINYINT      NOT NULL
   ,[Month Name]            VARCHAR(9)   NOT NULL
   ,[Month Of Year]         TINYINT      NOT NULL
   ,[Last Day Of Month]     VARCHAR(3)   NOT NULL
   ,[Work Day]              VARCHAR(3)   NOT NULL
   ,[Calendar Quarter]      TINYINT      NOT NULL
   ,[Calendar Year]         SMALLINT     NOT NULL
   ,[Calendar Year Month]   CHAR(7)      NOT NULL
   ,[Calendar Year Quarter] CHAR(6)      NOT NULL
   ,[Fiscal Month Of Year]  TINYINT      NOT NULL
   ,[Fiscal Quarter]        TINYINT      NOT NULL
   ,[Fiscal Year]           INT          NOT NULL
   ,[Fiscal Year Month]     CHAR(7)      NOT NULL
   ,[Fiscal Year Quarter]   CHAR(6)      NOT NULL
   ,CONSTRAINT Date_Key PRIMARY KEY CLUSTERED ([Date Key] ASC)
);
GO

EXEC sys.sp_addextendedproperty
    @name = N'Comments'
   ,@value = N'In the form: yyyymmdd'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Date Key';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Surrogate primary key'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Date Key';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'20041123'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Date Key';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Date Key';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Full date as a SQL datetime2 (time=00:00:00.0000000)'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Full Date Time';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'11/23/2004 2004-12-31 23:59:59.9999999'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Full Date Time';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Full Date Time';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Standard Date Format of YYYY/MM/DD'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Date Name';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'23-Nov-2004'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Date Name';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Date Name';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Date Name';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Standard US Date Format of MM/DD/YYYY'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Date Name US';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Standard European Union Date Format of DD/MM/YYYY'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Date Name EU';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Number of the day of week; Sunday = 1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Of Week';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'1..7'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Of Week';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Of Week';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Of Week';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Day name of week'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Name Of Week';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'Sunday'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Name Of Week';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Name Of Week';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Name Of Week';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Number of the day in the month'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Of Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'1..31'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Of Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Of Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Of Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Number of the day in the year'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'1..365'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Day Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Is today a weekday or a weekend'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Weekday Weekend';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'Weekday, Weekend'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Weekday Weekend';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Weekday Weekend';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Weekday Weekend';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Week of year'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Week Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'1..52 or 53'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Week Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Week Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Week Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Month name'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Month Name';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'November'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Month Name';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Month Name';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Month Name';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Month of year'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Month Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'1, 2, …, 12'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Month Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Month Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Month Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Is this the last day of the calendar month?'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Last Day Of Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'Yes, No'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Last Day Of Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Last Day Of Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Last Day Of Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Is this a work day?'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Work Day';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'Yes, No'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Work Day';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Work Day';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Work Day';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Calendar quarter'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'1, 2, 3, 4'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Calendar year'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'2004'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Calendar year and month'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Year Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'2004-01'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Year Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Year Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Year Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Calendar year and quarter'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Year Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'2004Q1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Year Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Year Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Calendar Year Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Fiscal month of year (1..12). FY starts in July'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Month Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'1, 2, …, 12'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Month Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Month Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Month Of Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Fiscal quarter'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'1, 2, 3, 4'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Fiscal year. Fiscal year begins in July.'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'2004'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Year';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Fiscal year and month'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Year Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'FY2004-01'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Year Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Year Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Year Month';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Fiscal year and quarter'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Year Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Example Values'
   ,@value = N'FY2004Q1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Year Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SCD Type'
   ,@value = N'1'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Year Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Source System'
   ,@value = N'Derived'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date'
   ,@level2type = N'COLUMN'
   ,@level2name = N'Fiscal Year Quarter';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Description'
   ,@value = N'Date dimension contains one row for every day, beginning at 1/1/2000. There may also be rows for "hasn''t happened yet."'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Table Type'
   ,@value = N'Dimension'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Used in schemas'
   ,@value = N'Sales (3 roles); Finance; Currency Rates; Sales Quota (2 roles; one at Cal Qtr level)'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date';
GO

EXEC sys.sp_addextendedproperty
    @name = N'View Name'
   ,@value = N'Date'
   ,@level0type = N'SCHEMA'
   ,@level0name = N'Dimension'
   ,@level1type = N'TABLE'
   ,@level1name = N'Date';
GO


