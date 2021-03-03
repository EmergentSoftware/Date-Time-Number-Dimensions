DROP TABLE IF EXISTS Dimension.Number;
CREATE TABLE Dimension.Number (
    NumberId            BIGINT       NOT NULL
   ,NumberWord          VARCHAR(500) NULL
   ,BinaryNumber        VARCHAR(16)  NULL
   ,HexNumber           VARCHAR(16)  NULL
   ,EvenOdd             VARCHAR(4)   NULL
   ,RomanNumeral        VARCHAR(9)   NULL
   ,Ones                TINYINT      NULL
   ,Tens                TINYINT      NULL
   ,Hundreds            TINYINT      NULL
   ,Thousands           TINYINT      NULL
   ,TenThousands        TINYINT      NULL
   ,HundredThousands    TINYINT      NULL
   ,Millions            TINYINT      NULL
   ,TenMillions         TINYINT      NULL
   ,HundredMillions     TINYINT      NULL
   ,Billions            TINYINT      NULL
   ,TenBillions         TINYINT      NULL
   ,HundredBillions     TINYINT      NULL
   ,Trillions           TINYINT      NULL
   ,TenTrillions        TINYINT      NULL
   ,HundredTrillions    TINYINT      NULL
   ,Quadrillions        TINYINT      NULL
   ,TenQuadrillions     TINYINT      NULL
   ,HundredQuadrillions TINYINT      NULL
   ,Quintillions        TINYINT      NULL
   ,CONSTRAINT Dimension_Number_NumberId PRIMARY KEY CLUSTERED (NumberId ASC)
);
GO