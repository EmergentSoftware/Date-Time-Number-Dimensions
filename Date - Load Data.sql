-- TRUNCATE TABLE Dimension.Date;

/**********************************************************************************************************************
** Description:  Populate date dimension
** Runtime:      4.5 - 33 minutes (AMD Ryzen 7 3800x 8 cores /16 logical processors | 32 GB memory)
** Record Count: 3,652,058 records (479.102 MB uncompressed) for the date range of 0001-01-01 - 9999-12-30
** Compression:  Page compression will result in a 237.883 MB size that will cause a slight CPU increase for queries
**                ALTER TABLE Dimension.Date REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE);
**********************************************************************************************************************/

DECLARE
    @BeginDate               datetime2(7) = '0001-01-01'
   ,@EndDate                 datetime2(7) = '9999-12-30'    /* Need to exclude a day for the IsLastDayOfMonth check */
   ,@UseWorkDayOffTable      bit          = 0               /* Using the WorkDayOff table will override weekends being set as work days off */
   ,@SetSaturdayAsWorkDayOff bit          = 1               /* 1 = All Saturdays will set Work Day to "No" */
   ,@SetSundayAsWorkDayOff   bit          = 1;              /* 1 = All Sundays will set Work Day to "No" */

/*
** Number of months to add to the date to get the current Fiscal date.
** Set this to the number of months to add to the current date to get the beginning of the Fiscal year.
** For example, if the Fiscal year begins July 1, put a 6 there.
** Negative values are also allowed, thus if your 2019 Fiscal year begins in July of 2018, put a -6.
*/
DECLARE @FiscalYearMonthsOffset int = 0;

/* Holds a flag so we can determine if the date is the last day of month */
DECLARE @IsLastDayOfMonthFlag varchar(3);

/* Holds a flag so we can determine if the date is a work day */
DECLARE @IsWorkDayFlag varchar(3) = 'Yes';

/* These two counters are used in our loop. */
DECLARE @DateCounter datetime2(7); /* Current date in loop */
DECLARE @FiscalCounter datetime2(7); /* Fiscal Year Date in loop */

/* Create a temp table to store the Integration.WorkDayOff records */
IF OBJECT_ID('tempdb..#WorkDayOff') IS NOT NULL
    BEGIN
        DROP TABLE #WorkDayOff;
    END;
CREATE TABLE #WorkDayOff (
    DayOff date NOT NULL
   ,CONSTRAINT Temp_DayOff PRIMARY KEY CLUSTERED (DayOff ASC)
);

IF OBJECT_ID('Integration.WorkDayOff') IS NOT NULL
    BEGIN
        SET @UseWorkDayOffTable = 1;
        INSERT INTO #WorkDayOff (DayOff) SELECT DayOff FROM Integration.WorkDayOff;
    END;

SET NOCOUNT ON;

/* Start the counter at the begin date */
SET @DateCounter = @BeginDate;

INSERT INTO Dimension.Date (
    [Date Key]
   ,[Full Date Time]
   ,[Date Name]
   ,[Date Name US]
   ,[Date Name EU]
   ,[Day Of Week]
   ,[Day Name Of Week]
   ,[Day Of Month]
   ,[Day Of Year]
   ,[Weekday Weekend]
   ,[Week Of Year]
   ,[Month Name]
   ,[Month Name Short]
   ,[Month Year]
   ,[Month Of Year]
   ,[Last Day Of Month]
   ,[Work Day]
   ,[Calendar Quarter]
   ,[Calendar Year]
   ,[Calendar Year Month]
   ,[Calendar Year Quarter]
   ,[Fiscal Month Of Year]
   ,[Fiscal Quarter]
   ,[Fiscal Quarter Name]
   ,[Fiscal Year]
   ,[Fiscal Year Name Short]
   ,[Fiscal Year Name Long]
   ,[Fiscal Year Month]
   ,[Fiscal Year Quarter]
)
VALUES
     (-1
     ,N'0001-01-01T00:00:00'
     ,'UNKNOWN'
     ,'UNKNOWN'
     ,'UNKNOWN'
     ,2
     ,'UNKNOWN'
     ,1
     ,1
     ,'UNKNOWN'
     ,1
     ,'UNKNOWN'
     ,'UKN'
     ,'UNKNOWN'
     ,1
     ,'NA'
     ,'NA'
     ,1
     ,1
     ,'UNKNOWN'
     ,'UNKNWN'
     ,1
     ,1
     ,'UKN'
     ,1
     ,'UNKN'
     ,'UNKNWN'
     ,'UNKNWN'
     ,'UNKNWN');

WHILE @DateCounter <= @EndDate
    BEGIN
        /* Calculate the current Fiscal date as an offset of the current date in the loop*/
        SET @FiscalCounter = DATEADD(MONTH, @FiscalYearMonthsOffset, @DateCounter);

        /* Set value for IsLastDayOfMonthFlag */
        IF MONTH(@DateCounter) = MONTH(DATEADD(DAY, 1, @DateCounter))
            BEGIN
                SET @IsLastDayOfMonthFlag = 'No';
            END;
        ELSE
            BEGIN
                SET @IsLastDayOfMonthFlag = 'Yes';
            END;

        /* Set value for IsWorkDayFlag */
        SET @IsWorkDayFlag = 'Yes';

        IF DATEPART(WEEKDAY, @DateCounter) = 7 /* Saturday */
        AND @SetSaturdayAsWorkDayOff = 1
            BEGIN
                SET @IsWorkDayFlag = 'No';
            END;

        IF DATEPART(WEEKDAY, @DateCounter) = 1 /* Sunday */
        AND @SetSundayAsWorkDayOff = 1
            BEGIN
                SET @IsWorkDayFlag = 'No';
            END;

        IF @UseWorkDayOffTable = 1
            BEGIN
                IF EXISTS (SELECT   * FROM  #WorkDayOff AS WDO WHERE WDO.DayOff = @DateCounter)
                    BEGIN
                        SET @IsWorkDayFlag = 'No';
                    END;
            END;

        /* Add a record into the date dimension table for this date */
        INSERT INTO Dimension.Date (
            [Date Key]
           ,[Full Date Time]
           ,[Date Name]
           ,[Date Name US]
           ,[Date Name EU]
           ,[Day Of Week]
           ,[Day Name Of Week]
           ,[Day Of Month]
           ,[Day Of Year]
           ,[Weekday Weekend]
           ,[Week Of Year]
           ,[Month Name]
           ,[Month Name Short]
           ,[Month Year]
           ,[Month Of Year]
           ,[Last Day Of Month]
           ,[Work Day]
           ,[Calendar Quarter]
           ,[Calendar Year]
           ,[Calendar Year Month]
           ,[Calendar Year Quarter]
           ,[Fiscal Month Of Year]
           ,[Fiscal Quarter]
           ,[Fiscal Quarter Name]
           ,[Fiscal Year]
           ,[Fiscal Year Name Short]
           ,[Fiscal Year Name Long]
           ,[Fiscal Year Month]
           ,[Fiscal Year Quarter]
        )
        VALUES
             (CAST(CONVERT(char(8), @DateCounter, 112) AS int)                                                                                                                                                                      /* Date Key */
             ,@DateCounter                                                                                                                                                                                                          /* Full Date */
             ,RIGHT('000' + CAST(YEAR(@DateCounter) AS varchar(4)), 4) + '/' + RIGHT('00' + RTRIM(CAST(DATEPART(MONTH, @DateCounter) AS char(2))), 2) + '/' + RIGHT('00' + RTRIM(CAST(DATEPART(DAY, @DateCounter) AS char(2))), 2)  /* Date Name */
             ,RIGHT('00' + RTRIM(CAST(DATEPART(MONTH, @DateCounter) AS char(2))), 2) + '/' + RIGHT('00' + RTRIM(CAST(DATEPART(DAY, @DateCounter) AS char(2))), 2) + '/' + RIGHT('000' + CAST(YEAR(@DateCounter) AS varchar(4)), 4)  /* Date Name US */
             ,RIGHT('00' + RTRIM(CAST(DATEPART(DAY, @DateCounter) AS char(2))), 2) + '/' + RIGHT('00' + RTRIM(CAST(DATEPART(MONTH, @DateCounter) AS char(2))), 2) + '/' + RIGHT('000' + CAST(YEAR(@DateCounter) AS varchar(4)), 4)  /* Date Name EU */
             ,DATEPART(WEEKDAY, @DateCounter)                                                                                                                                                                                       /* Day Of Week */
             ,DATENAME(WEEKDAY, @DateCounter)                                                                                                                                                                                       /* Day Name Of Week */
             ,DATENAME(DAY, @DateCounter)                                                                                                                                                                                           /* Day Of Month */
             ,DATENAME(DAYOFYEAR, @DateCounter)                                                                                                                                                                                     /* Day Of Year */
             ,CASE DATENAME(WEEKDAY, @DateCounter)
                  WHEN 'Saturday'
                      THEN 'Weekend'
                  WHEN 'Sunday'
                      THEN 'Weekend'
                  ELSE 'Weekday'
              END                                                                                                                                                                                                                   /* Weekday Weekend */
             ,DATENAME(WEEK, @DateCounter)                                                                                                                                                                                          /* Week Of Year */
             ,DATENAME(MONTH, @DateCounter)                                                                                                                                                                                         /* Month Name */
             ,FORMAT(@DateCounter, 'MMM')                                                                                                                                                                                           /* Month Name Short */
             ,FORMAT(@DateCounter, 'MMM') + ' ' + RIGHT('000' + CAST(YEAR(@DateCounter) AS varchar(4)), 4)                                                                                                                          /* Month Year */
             ,MONTH(@DateCounter)                                                                                                                                                                                                   /* Month Of Year */
             ,@IsLastDayOfMonthFlag                                                                                                                                                                                                 /* Last Day Of Month */
             ,@IsWorkDayFlag                                                                                                                                                                                                        /* Work Day */
             ,DATENAME(QUARTER, @DateCounter)                                                                                                                                                                                       /* Calendar Quarter */
             ,YEAR(@DateCounter)                                                                                                                                                                                                    /* Calendar Year */
             ,RIGHT('000' + CAST(YEAR(@DateCounter) AS varchar(4)), 4) + '-' + RIGHT('00' + RTRIM(CAST(DATEPART(MONTH, @DateCounter) AS char(2))), 2)                                                                               /* Calendar Year Month */
             ,RIGHT('000' + CAST(YEAR(@DateCounter) AS varchar(4)), 4) + 'Q' + DATENAME(QUARTER, @DateCounter)                                                                                                                      /* Calendar Year Quarter */
             ,MONTH(@FiscalCounter)                                                                                                                                                                                                 /* Fiscal Month Of Year */
             ,DATENAME(QUARTER, @FiscalCounter)                                                                                                                                                                                     /* Fiscal Quarter */
             ,'FY' + CAST(DATENAME(QUARTER, @FiscalCounter) AS varchar(1))                                                                                                                                                          /* Fiscal Quarter Name */
             ,YEAR(@FiscalCounter)                                                                                                                                                                                                  /* Fiscal Year */
             ,'FY' + RIGHT('000' + CAST(YEAR(@DateCounter) AS varchar(4)), 2)                                                                                                                                                       /* Fiscal Year Name Short */
             ,'FY' + RIGHT('000' + CAST(YEAR(@DateCounter) AS varchar(4)), 4)                                                                                                                                                       /* Fiscal Year Name Long */
             ,RIGHT('000' + CAST(YEAR(@FiscalCounter) AS varchar(4)), 4) + '-' + RIGHT('00' + RTRIM(CAST(DATEPART(MONTH, @FiscalCounter) AS char(2))), 2)                                                                           /* Fiscal Year Month */
             ,RIGHT('000' + CAST(YEAR(@FiscalCounter) AS varchar(4)), 4) + 'Q' + DATENAME(QUARTER, @FiscalCounter)                                                                                                                  /* Fiscal Year Quarter */
            );

        /* Increment the date counter for next pass thru the loop */
        SET @DateCounter = DATEADD(DAY, 1, @DateCounter);
    END;
