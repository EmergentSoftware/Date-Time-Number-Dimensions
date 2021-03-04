--DROP TABLE IF EXISTS Dimension.Number;
/* Remove placement columns (Ones, Tens, ..., Quintillions) you will not need */
CREATE TABLE Dimension.Number (
    [Number Key]           BIGINT       NOT NULL
   ,[Number Word]          VARCHAR(500) NULL
   ,[Binary Number]        VARCHAR(16)  NULL
   ,[Hex Number]           VARCHAR(16)  NULL
   ,[Even Odd]             VARCHAR(4)   NULL
   ,[Roman Numeral]        VARCHAR(9)   NULL
   ,Ones                   TINYINT      NULL
   ,Tens                   TINYINT      NULL
   ,Hundreds               TINYINT      NULL
   ,Thousands              TINYINT      NULL
   ,[Ten Thousands]        TINYINT      NULL
   ,[Hundred Thousands]    TINYINT      NULL
   ,Millions               TINYINT      NULL
   ,[Ten Millions]         TINYINT      NULL
   ,[Hundred Millions]     TINYINT      NULL
   ,Billions               TINYINT      NULL
   ,[Ten Billions]         TINYINT      NULL
   ,[Hundred Billions]     TINYINT      NULL
   ,Trillions              TINYINT      NULL
   ,[Ten Trillions]        TINYINT      NULL
   ,[Hundred Trillions]    TINYINT      NULL
   ,Quadrillions           TINYINT      NULL
   ,[Ten Quadrillions]     TINYINT      NULL
   ,[Hundred Quadrillions] TINYINT      NULL
   ,Quintillions           TINYINT      NULL
   ,CONSTRAINT Dimension_Number_Number_Key PRIMARY KEY CLUSTERED ([Number Key] ASC)
);
GO