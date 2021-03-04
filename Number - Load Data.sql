--TRUNCATE TABLE Dimension.Number;

-- SQL Prompt formatting off
SET NOCOUNT ON;

/* Change @HowManyNumberToCreate to the number of numbers you wish to create in your numbers table + zero
*  Load up your number dimension table once. The quantity of numbers you need will depend on your data.
*  This is done with a while loops vs a generic batch statement.
*
*  Runtimes on (AMD Ryzen 7 3800x 8 cores /16 logical processors | 32 GB memory)
*         1,000     Numbers  =  0 seconds (0.102 MB)
*         10,000    Numbers  =  3 seconds (1.070 MB)
*         100,000   Numbers =   1 minutes 34 seconds (11.016 MB)
*         1,000,000 Numbers =  23 minutes 39 seconds (121.914 MB)
*
*  Numbers table uses: 
*    Join to find gaps in number join
*    Lists to output results in a query for the count of number, this allows a result of 0 count for a specific number
*    Join to return the NumberWord to print on checks, join again for cents
*    Join to output Roman Numerals
*    Join to group by number placements tens, hundreds, millions
*    Join to use as a dimension slicer
*    Query to find binary, hex numbers
*    Removing Duplicates from Strings in SQL Serve https://www.mssqltips.com/sqlservertip/4140/removing-duplicates-from-strings-in-sql-server/
*    Validate the contents of large dynamic SQL strings in SQL Server https://www.mssqltips.com/sqlservertip/3185/validate-the-contents-of-large-dynamic-sql-strings-in-sql-server/
*    Sort characters withing a string https://vyaskn.tripod.com/fun_with_numbers_in_t-sql_queries.htm
*    View other uses via Stack Overflow https://stackoverflow.com/search?page=1&tab=Relevance&q=%22numbers%20table%22
*    View other uses via Stack Exchange https://dba.stackexchange.com/search?q=%22numbers+table%22
*/

DECLARE @HowManyNumberToCreate BIGINT = 100000;



/* NumberWord Variables */
DROP TABLE IF EXISTS #NumbersTable;
CREATE TABLE #NumbersTable (number CHAR(2) NOT NULL, word VARCHAR(10) NOT NULL);
DECLARE @InputNumber VARCHAR(38);
DECLARE @NumberWord VARCHAR(8000);
DECLARE @Counter INT;
DECLARE @Loops INT;
DECLARE @Position INT;
DECLARE @Chunk CHAR(3);
DECLARE @TensOnes CHAR(2);
DECLARE @Hundreds CHAR(1);
DECLARE @Tens CHAR(1);
DECLARE @Ones CHAR(1);

/* BinaryNumber variables*/
DECLARE @Binary VARCHAR(16);

/* HexNumber Variables */
DECLARE @HexNumber BIGINT;
DECLARE @HexSequence CHAR(16) = '0123456789ABCDEF';
DECLARE @HexValue VARCHAR(50);
DECLARE @HexDigit CHAR(1);

/* RomanNumeral Variables */
DECLARE @RomanNumeral VARCHAR(9);

/* Number Placements Variables */
DECLARE @NumberString VARCHAR(19);

DECLARE @Number BIGINT = 0;

WHILE @Number <= @HowManyNumberToCreate
    BEGIN

        /* Initialize NumberWord variables */
        SELECT
            @InputNumber = CONVERT(VARCHAR(38), @Number)
           ,@NumberWord  = ''
           ,@Counter     = 1;

        SELECT @Position = LEN(@InputNumber) - 2, @Loops = LEN(@InputNumber) / 3;

        /* Make sure there is an extra loop added for the remaining numbers */
        IF LEN(@InputNumber) % 3 <> 0
            BEGIN
                SET @Loops = @Loops + 1;
            END;

        /* Insert data for the numbers and words */
        INSERT INTO #NumbersTable (number, word)
        VALUES
             ('00', '')         ,('01', 'one')      ,('02', 'two')
			,('03', 'three')    ,('04', 'four')     ,('05', 'five')
            ,('06', 'six')      ,('07', 'seven')    ,('08', 'eight')
			,('09', 'nine')     ,('10', 'ten')      ,('11', 'eleven')
            ,('12', 'twelve')   ,('13', 'thirteen') ,('14', 'fourteen')
            ,('15', 'fifteen')  ,('16', 'sixteen')  ,('17', 'seventeen')
            ,('18', 'eighteen') ,('19', 'nineteen') ,('20', 'twenty')
            ,('30', 'thirty')   ,('40', 'forty')    ,('50', 'fifty')
            ,('60', 'sixty')    ,('70', 'seventy')  ,('80', 'eighty')
            ,('90', 'ninety');

        WHILE @Counter <= @Loops
            BEGIN

                /* Get chunks of 3 numbers at a time, padded with leading zeros */
                SET @Chunk = RIGHT('000' + SUBSTRING(@InputNumber, @Position, 3), 3);

                IF @Chunk <> '000'
                    BEGIN
                        SELECT
                            @TensOnes = SUBSTRING(@Chunk, 2, 2)
                           ,@Hundreds = SUBSTRING(@Chunk, 1, 1)
                           ,@Tens     = SUBSTRING(@Chunk, 2, 1)
                           ,@Ones     = SUBSTRING(@Chunk, 3, 1);

                        /* If twenty or less, use the word directly from #NumbersTable */
                        IF CONVERT(INT, @TensOnes) <= 20 OR @Ones = '0'
                            BEGIN
                                SET @NumberWord = (
									SELECT TOP (1) word 
									FROM #NumbersTable 
									WHERE @TensOnes = number
								) + CASE @Counter
										WHEN 1 THEN  '' /* No name */
										WHEN 2 THEN  ' thousand '
										WHEN 3 THEN  ' million '
										WHEN 4 THEN  ' billion '
										WHEN 5 THEN  ' trillion '
										WHEN 6 THEN  ' quadrillion '
										WHEN 7 THEN  ' quintillion '
										WHEN 8 THEN  ' sextillion '
										WHEN 9 THEN  ' septillion '
										WHEN 10 THEN ' octillion '
										WHEN 11 THEN ' nonillion '
										WHEN 12 THEN ' decillion '
										WHEN 13 THEN ' undecillion '
										ELSE ''
									END + @NumberWord;
                            END;
                        ELSE
                            BEGIN
                                SET @NumberWord = ' ' + (
									SELECT TOP (1) word 
									FROM #NumbersTable 
									WHERE @Tens + '0' = number
								) + '-' + (
									SELECT TOP (1) word 
									FROM #NumbersTable WHERE 
									'0' + @Ones = number
								) + CASE @Counter
										WHEN 1 THEN  '' /* No name */
										WHEN 2 THEN  ' thousand '
										WHEN 3 THEN  ' million '
										WHEN 4 THEN  ' billion '
										WHEN 5 THEN  ' trillion '
										WHEN 6 THEN  ' quadrillion '
										WHEN 7 THEN  ' quintillion '
										WHEN 8 THEN  ' sextillion '
										WHEN 9 THEN  ' septillion '
										WHEN 10 THEN ' octillion '
										WHEN 11 THEN ' nonillion '
										WHEN 12 THEN ' decillion '
										WHEN 13 THEN ' undecillion '
										ELSE ''
									END + @NumberWord;
                            END;

                        /* Get the hundreds */
                        IF @Hundreds <> '0'
                            BEGIN
                                SET @NumberWord = (
									SELECT TOP (1) word 
									FROM #NumbersTable 
									WHERE '0' + @Hundreds = number
								) + ' hundred ' + @NumberWord;
                            END;
                    END;

                SELECT @Counter = @Counter + 1, @Position = @Position - 3;

            END;

        /* Remove any double spaces */
        SET @NumberWord = LTRIM(RTRIM(REPLACE(@NumberWord, '  ', ' ')));
        SET @NumberWord = UPPER(LEFT(@NumberWord, 1)) + SUBSTRING(@NumberWord, 2, 8000);

        /* Binary Number */
        SET @Binary = 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 32768) > 0 THEN '1' ELSE '0'END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 16384) > 0 THEN '1' ELSE '0'END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 8192) > 0 THEN '1' ELSE '0' END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 4096) > 0 THEN '1'ELSE '0' END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 2048) > 0 THEN '1' ELSE '0' END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 1024) > 0 THEN '1' ELSE '0' END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 512) > 0 THEN '1' ELSE '0' END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 256) > 0 THEN '1' ELSE '0' END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 128) > 0 THEN '1' ELSE '0' END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 64) > 0 THEN '1' ELSE '0' END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 32) > 0 THEN '1' ELSE '0' END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 16) > 0 THEN '1' ELSE '0' END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 8) > 0 THEN '1' ELSE '0' END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 4) > 0 THEN '1' ELSE '0' END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 2) > 0 THEN '1' ELSE '0' END + 
			CASE WHEN CONVERT(VARCHAR(16), @Number & 1) > 0 THEN '1' ELSE '0' END;


        /*Hex Number */
        SET @HexNumber = @Number;
        SET @HexValue = SUBSTRING(@HexSequence, (@HexNumber % 16) + 1, 1);

        WHILE @HexNumber > 0
			BEGIN
				SET @HexDigit = SUBSTRING(@HexSequence, ((@HexNumber / 16) % 16) + 1, 1);

				SET @HexNumber = @HexNumber / 16;
				IF @HexNumber <> 0
					BEGIN
						SET @HexValue = @HexDigit + @HexValue;
					END;
			END;


        /* Roman Numerals */
        IF @Number < 4000
            BEGIN
                SET @RomanNumeral = 
					REPLICATE('M', @Number / 1000) + 
					REPLACE(REPLACE(REPLACE(
						REPLICATE('C', @Number % 1000 / 100), 
						REPLICATE('C', 9), 'CM'), 
						REPLICATE('C', 5), 'D'), 
						REPLICATE('C', 4), 'CD') + 
					REPLACE(REPLACE(REPLACE(
						REPLICATE('X', @Number % 100 / 10), 
						REPLICATE('X', 9), 'XC'), 
						REPLICATE('X', 5), 'L'), 
						REPLICATE('X', 4), 'XL') + 
					REPLACE(REPLACE(REPLACE(
						REPLICATE('I', @Number % 10), 
						REPLICATE('I', 9), 'IX'), 
						REPLICATE('I', 5), 'V'), 
						REPLICATE('I', 4), 'IV');
            END;
        ELSE
            BEGIN
                SET @RomanNumeral = '';
            END;

        /* Number Placements */
        SET @NumberString = @Number;

        INSERT INTO Dimension.Number (
            NumberId
           ,NumberWord
           ,BinaryNumber
           ,HexNumber
           ,EvenOdd
           ,RomanNumeral
           ,Ones
           ,Tens
           ,Hundreds
           ,Thousands
           ,TenThousands
           ,HundredThousands
           ,Millions
           ,TenMillions
           ,HundredMillions
           ,Billions
           ,TenBillions
           ,HundredBillions
           ,Trillions
           ,TenTrillions
           ,HundredTrillions
           ,Quadrillions
           ,TenQuadrillions
           ,HundredQuadrillions
           ,Quintillions
        )
        SELECT
            NumberId            = @Number
           ,NumberWord          = IIF(@Number = 0, 'Zero', @NumberWord)
           ,BinaryNumber        = @Binary
           ,HexNumber           = @HexValue
           ,EvenOdd             = CASE @Number % 2 WHEN 0 THEN 'Even' ELSE 'Odd' END
           ,RomanNumeral        = IIF(@Number = 0, 'Nulla', @RomanNumeral)
           ,Ones                = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 0,  1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 0,  1), 0)
           ,Tens                = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 1,  1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 1,  1), 0)
           ,Hundreds            = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 2,  1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 2,  1), 0)
           ,Thousands           = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 3,  1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 3,  1), 0)
           ,TenThousands        = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 4,  1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 4,  1), 0)
           ,HundredThousands    = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 5,  1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 5,  1), 0)
           ,Millions            = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 6,  1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 6,  1), 0)
           ,TenMillions         = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 7,  1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 7,  1), 0)
           ,HundredMillions     = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 8,  1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 8,  1), 0)
           ,Billions            = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 9,  1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 9,  1), 0)
           ,TenBillions         = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 10, 1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 10, 1), 0)
           ,HundredBillions     = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 11, 1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 11, 1), 0)
           ,Trillions           = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 12, 1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 12, 1), 0)
           ,TenTrillions        = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 13, 1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 13, 1), 0)
           ,HundredTrillions    = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 14, 1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 14, 1), 0)
           ,Quadrillions        = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 15, 1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 15, 1), 0)
           ,TenQuadrillions     = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 16, 1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 16, 1), 0)
           ,HundredQuadrillions = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 17, 1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 17, 1), 0)
           ,Quintillions        = IIF(LEN(SUBSTRING(@NumberString, LEN(@NumberString) - 18, 1)) > 0, SUBSTRING(@NumberString, LEN(@NumberString) - 18, 1), 0);
   
        SET @Number = @Number + 1;
    END;

SET NOCOUNT OFF;
-- SQL Prompt formatting on