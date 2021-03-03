/**********************************************************************************************************************
** Author:       Kevin Martin (Emergent Software)
** Created On:   11/17/2020
** Modified On:  11/17/2020
** Description:  Populate date dimension
** Runtime:      4.5 - 33 minutes (AMD Ryzen 7 3800x 8 cores /16 logical processors | 32 GB memory)
** Record Count: 3,652,058 records (479.102 MB uncompressed) for the date range of 0001-01-01 - 9999-12-30
** Compression:  Page compression will result in a 237.883 MB size that will cause a slight CPU increase for queries
**                ALTER TABLE Dimension.Date REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE);
**********************************************************************************************************************/
CREATE OR ALTER PROCEDURE Integration.DateLoad
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE
            @BeginDate DATETIME2(7) = '0001-01-01'
           ,@EndDate   DATETIME2(7) = '9999-12-30' /* Need to exclude a day for the IsLastDayOfMonth check */;

        /*
        ** Number of months to add to the date to get the current Fiscal date.
        ** Set this to the number of months to add to the current date to get the beginning of the Fiscal year.
		** For example, if the Fiscal year begins July 1, put a 6 there.
        ** Negative values are also allowed, thus if your 2019 Fiscal year begins in July of 2018, put a -6.
		*/
        DECLARE @FiscalYearMonthsOffset INT = 0;

        /* Holds a flag so we can determine if the date is the last day of month */
        DECLARE @IsLastDayOfMonthFlag VARCHAR(3);

        /* Holds a flag so we can determine if the date is a work day */
        DECLARE
            @IsWorkDayFlag          VARCHAR(3) = 'Yes'
           ,@UseWorkDayOffTableFlag BIT        = 0;

        /* These two counters are used in our loop. */
        DECLARE @DateCounter DATETIME2(7); /* Current date in loop */
        DECLARE @FiscalCounter DATETIME2(7); /* Fiscal Year Date in loop */

        /* Create a temp table to store the Integration.WorkDayOff records */
        IF OBJECT_ID('tempdb..#WorkDayOff') IS NOT NULL
            BEGIN
                DROP TABLE #WorkDayOff;
            END;
        CREATE TABLE #WorkDayOff (
            DayOff DATE NOT NULL
           ,CONSTRAINT Temp_DayOff PRIMARY KEY CLUSTERED (DayOff ASC)
        );

        IF OBJECT_ID('Integration.WorkDayOff') IS NOT NULL
            BEGIN
                SET @UseWorkDayOffTableFlag = 1;
                INSERT INTO #WorkDayOff (DayOff) SELECT DayOff FROM Integration.WorkDayOff;
            END;

        /* Start the counter at the begin date */
        SET @DateCounter = @BeginDate;

        /* Truncate and load */
        TRUNCATE TABLE Dimension.Date;

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
           ,[Fiscal Year Name]
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
             ,'UNKNOWN'
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

                /* Set value for IsWorkDayFlag. Could use the Integration.WorkDayOff table stores non-work days like holidays. */
                IF @UseWorkDayOffTableFlag = 1
                    BEGIN
                        IF EXISTS (SELECT 1 FROM #WorkDayOff AS WDO WHERE WDO.DayOff = @DateCounter)
                            BEGIN
                                SET @IsWorkDayFlag = 'No';
                            END;
                        ELSE
                            BEGIN
                                SET @IsWorkDayFlag = 'Yes';
                            END;
                    END;

                /* Set value for IsWorkDayFlag. Could use Saturday and Sunday like below */
                IF DATEPART(WEEKDAY, @DateCounter) IN (1, 7) /* Saturday and Sunday */
                    BEGIN
                        SET @IsWorkDayFlag = 'No';
                    END;
                ELSE
                    BEGIN
                        SET @IsWorkDayFlag = 'Yes';
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
                   ,[Fiscal Year Name]
                   ,[Fiscal Year Month]
                   ,[Fiscal Year Quarter]
                )
                VALUES
                     (CAST(CONVERT(CHAR(8), @DateCounter, 112) AS INT)                                                                                                                                                                    /* Date Key */
                     ,@DateCounter                                                                                                                                                                                                        /* Full Date */
                     ,RIGHT('000' + CAST(YEAR(@DateCounter) AS VARCHAR(4)), 4) + '/' + RIGHT('00' + RTRIM(CAST(DATEPART(MONTH, @DateCounter) AS CHAR(2))), 2) + '/' + RIGHT('00' + RTRIM(CAST(DATEPART(DAY, @DateCounter) AS CHAR(2))), 2)/* Date Name */
                     ,RIGHT('00' + RTRIM(CAST(DATEPART(MONTH, @DateCounter) AS CHAR(2))), 2) + '/' + RIGHT('00' + RTRIM(CAST(DATEPART(DAY, @DateCounter) AS CHAR(2))), 2) + '/' + RIGHT('000' + CAST(YEAR(@DateCounter) AS VARCHAR(4)), 4)/* Date Name US */
                     ,RIGHT('00' + RTRIM(CAST(DATEPART(DAY, @DateCounter) AS CHAR(2))), 2) + '/' + RIGHT('00' + RTRIM(CAST(DATEPART(MONTH, @DateCounter) AS CHAR(2))), 2) + '/' + RIGHT('000' + CAST(YEAR(@DateCounter) AS VARCHAR(4)), 4)/* Date Name EU */
                     ,DATEPART(WEEKDAY, @DateCounter)                                                                                                                                                                                     /* Day Of Week */
                     ,DATENAME(WEEKDAY, @DateCounter)                                                                                                                                                                                     /* Day Name Of Week */
                     ,DATENAME(DAY, @DateCounter)                                                                                                                                                                                         /* Day Of Month */
                     ,DATENAME(DAYOFYEAR, @DateCounter)                                                                                                                                                                                   /* Day Of Year */
                     ,CASE DATENAME(WEEKDAY, @DateCounter)
                          WHEN 'Saturday' THEN
                              'Weekend'
                          WHEN 'Sunday' THEN
                              'Weekend'
                          ELSE
                              'Weekday'
                      END                                                                                                                                                                                                                 /* Weekday Weekend */
                     ,DATENAME(WEEK, @DateCounter)                                                                                                                                                                                        /* Week Of Year */
                     ,DATENAME(MONTH, @DateCounter)                                                                                                                                                                                       /* Month Name */
                     ,FORMAT(@DateCounter, 'MMM')                                                                                                                                                                                         /* Month Name Short */
                     ,FORMAT(@DateCounter, 'MMM') + ' ' + RIGHT('000' + CAST(YEAR(@DateCounter) AS VARCHAR(4)), 4)                                                                                                                        /* Month Year */
                     ,MONTH(@DateCounter)                                                                                                                                                                                                 /* Month Of Year */
                     ,@IsLastDayOfMonthFlag                                                                                                                                                                                               /* Last Day Of Month */
                     ,@IsWorkDayFlag                                                                                                                                                                                                      /* Work Day */
                     ,DATENAME(QUARTER, @DateCounter)                                                                                                                                                                                     /* Calendar Quarter */
                     ,YEAR(@DateCounter)                                                                                                                                                                                                  /* Calendar Year */
                     ,RIGHT('000' + CAST(YEAR(@DateCounter) AS VARCHAR(4)), 4) + '-' + RIGHT('00' + RTRIM(CAST(DATEPART(MONTH, @DateCounter) AS CHAR(2))), 2)                                                                             /* Calendar Year Month */
                     ,RIGHT('000' + CAST(YEAR(@DateCounter) AS VARCHAR(4)), 4) + 'Q' + DATENAME(QUARTER, @DateCounter)                                                                                                                    /* Calendar Year Quarter */
                     ,MONTH(@FiscalCounter)                                                                                                                                                                                               /* Fiscal Month Of Year */
                     ,DATENAME(QUARTER, @FiscalCounter)                                                                                                                                                                                   /* Fiscal Quarter */
                     ,'FY' + CAST(DATENAME(QUARTER, @FiscalCounter) AS VARCHAR(1))                                                                                                                                                        /* Fiscal Quarter Name */
                     ,YEAR(@FiscalCounter)                                                                                                                                                                                                /* Fiscal Year */
                     ,'FY' + RIGHT('000' + CAST(YEAR(@DateCounter) AS VARCHAR(4)), 2)                                                                                                                                                     /* Fiscal Year Name */
                     ,RIGHT('000' + CAST(YEAR(@FiscalCounter) AS VARCHAR(4)), 4) + '-' + RIGHT('00' + RTRIM(CAST(DATEPART(MONTH, @FiscalCounter) AS CHAR(2))), 2)                                                                         /* Fiscal Year Month */
                     ,RIGHT('000' + CAST(YEAR(@FiscalCounter) AS VARCHAR(4)), 4) + 'Q' + DATENAME(QUARTER, @FiscalCounter)                                                                                                                /* Fiscal Year Quarter */
                    );

                /* Increment the date counter for next pass thru the loop */
                SET @DateCounter = DATEADD(DAY, 1, @DateCounter);
            END;
    END;