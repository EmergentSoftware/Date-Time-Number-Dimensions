CREATE TABLE Dimension.Time (
    [Time Key]               INT         NOT NULL
   ,[Hour 24]                INT         NOT NULL
   ,[Hour 24 Short]          CHAR(2)     NOT NULL
   ,[Hour 24 Medium]         CHAR(5)     NOT NULL
   ,[Hour 24 Full]           CHAR(8)     NOT NULL
   ,[Hour 12]                INT         NOT NULL
   ,[Hour 12 Short]          CHAR(5)     NOT NULL
   ,[Hour 12 Short Trim]     VARCHAR(5)  NOT NULL
   ,[Hour 12 Medium]         CHAR(8)     NOT NULL
   ,[Hour 12 Medium Trim]    VARCHAR(8)  NOT NULL
   ,[Hour 12 Full]           CHAR(11)    NOT NULL
   ,[Hour 12 Full Trim]      VARCHAR(11) NOT NULL
   ,[AM PM Code]             BIT         NOT NULL
   ,[AM PM]                  CHAR(2)     NOT NULL
   ,Minute                   INT         NOT NULL
   ,[Minute Of Day]          INT         NOT NULL
   ,[Minute Code]            INT         NOT NULL
   ,[Minute Short]           CHAR(2)     NOT NULL
   ,[Minute 24 Full]         CHAR(8)     NOT NULL
   ,[Minute 12 Full]         CHAR(11)    NOT NULL
   ,[Minute 12 Full Trim]    VARCHAR(14) NOT NULL
   ,[Half Hour Code]         INT         NOT NULL
   ,[Half Hour]              BIT         NOT NULL
   ,[Half Hour Short]        CHAR(2)     NOT NULL
   ,[Half Hour 24 Full]      CHAR(8)     NOT NULL
   ,[Half Hour 12 Full]      CHAR(11)    NOT NULL
   ,[Half Hour 12 Full Trim] VARCHAR(14) NOT NULL
   ,Second                   INT         NOT NULL
   ,[Second Of Day]          INT         NOT NULL
   ,[Second Short]           CHAR(2)     NOT NULL
   ,[Full Time 24]           CHAR(8)     NOT NULL
   ,[Full Time 12]           CHAR(11)    NOT NULL
   ,[Full Time 12 Trim]      VARCHAR(14) NOT NULL
   ,[Full Time]              TIME(7)     NOT NULL
   ,CONSTRAINT Dimension_Time_Time_Key PRIMARY KEY CLUSTERED ([Time Key] ASC)
);