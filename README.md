# Date Time Number Dimensions
This project contains SQL Server T-SQL scripts to create the data warehouse dimensions or business intelligence tables and load the tables with data. A Number table is also known as a tally table.

1. Execute the create table script for either the date, time or number
2. Execute the load data script for eather the date, time or number

## Date - Load Data
- The date load script will create a record 3,652,058 records (479.102 MB uncompressed) for the date range of 0001-01-01 - 9999-12-30
- Page compression will result in a 237.883 MB size that will cause a slight CPU increase for queries
- There is an option to create a Integration.WorkDayOff table. This can be used if the use case of business holidays are required. Otherwise you can use the Saturday, Sunday in the script.

## Time - Load Data
- The time load script will create 86,400 records | 1 second grain.

## Number - Load Data
- The number load script will create as many number records as you need for your data situation. This table provides more attributes than just a number to join on. The numbers are converted into words (One hundred twenty three), roman numerals, number placements (tens, hundreds, millions) good for grouping on, binary numbers, hex numbers, even/odd.