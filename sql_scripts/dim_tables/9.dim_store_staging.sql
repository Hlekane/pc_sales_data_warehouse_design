/*Drop the initial store dimension without a unique ID*/
DROP TABLE
  pc_sales_Stg.dbo.dim_store
  /* Create a new table and insert a unique ID*/
create table
  Pc_Sales_Stg.dbo.dim_store (
    Store_ID INT IDENTITY (1, 1) PRIMARY KEY,
    Shop_Name nvarchar (255) NOT NULL,
    Shop_Age nvarchar (255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE ()
  )
  /*Insert data into the store dimension from the staging dataset, 
   use distinct to remove duplicates*/
insert into
  Pc_Sales_Stg.Dbo.Dim_Store (Shop_Name, Shop_Age)
select
  distinct Shop_Name,
  Shop_Age
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg
  /*Check whether the table was successfully created*/
select
from
  Pc_Sales_Stg.dbo.Dim_Store