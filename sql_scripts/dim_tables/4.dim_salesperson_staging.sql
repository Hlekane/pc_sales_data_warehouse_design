/*Drop the initial salesperson dimension without a unique ID*/
DROP TABLE
  pc_sales_stg.dbo.dim_salesperson
  /* Create a new table and insert a unique ID*/
create table
  Pc_Sales_Stg.dbo.dim_salesperson (
    Salesperson_ID INT IDENTITY (1, 1) PRIMARY KEY,
    Sales_Person_Name nvarchar (255) NOT NULL,
    Sales_Person_Department nvarchar (255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE ()
  )
  /* Insert data into the salesperson dimension from the staging dataset,
   use distinct to remove duplicates*/
insert into
  Pc_Sales_Stg.Dbo.Dim_Salesperson (Sales_Person_Name, Sales_Person_Department)
select
  distinct Sales_Person_Name,
  Sales_Person_Department
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg
  /*Check whether the table was successfully created*/
select
  *
from
  Pc_Sales_Stg.dbo.Dim_Salesperson