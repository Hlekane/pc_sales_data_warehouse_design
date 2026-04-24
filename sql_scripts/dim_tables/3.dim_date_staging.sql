/*Drop the initial date dimension without a unique ID*/
DROP TABLE
  pc_sales_stg.dbo.dim_date
  /*Create a new table and insert a unique ID*/
create table
  Pc_Sales_Stg.dbo.dim_date (
    Date_ID INT IDENTITY (1, 1) PRIMARY KEY,
    Purchase_Date datetime2 (7) NOT NULL,
    Ship_Date nvarchar (50) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE ()
  )
  /*Insert data into the date dimension from the staging dataset, use 
   distinct to remove duplicates*/
insert into
  Pc_Sales_Stg.Dbo.Dim_Date (Purchase_Date, Ship_Date)
select
  distinct Purchase_Date,
  Ship_Date
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg
  /*Check whether the table was successfully created*/
select
  *
from
  Pc_Sales_Stg.dbo.Dim_Date