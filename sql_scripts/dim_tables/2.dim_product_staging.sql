/*Drop the initial product dimension without a unique ID*/
DROP TABLE
  pc_sales_Stg.dbo.dim_product
  /*Create a new table and insert a unique ID*/
create table
  Pc_Sales_Stg.dbo.dim_product (
    Product_ID INT IDENTITY (1, 1) PRIMARY KEY,
    PC_Make nvarchar (255) NOT NULL,
    PC_Model nvarchar (255) NOT NULL,
    Storage_Type nvarchar (255) NOT NULL,
    Storage_Capacity nvarchar (255) NOT NULL,
    RAM nvarchar (255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE ()
  )
  /*Insert data into the product dimension from the staging dataset, use 
   distinct to remove duplicates*/
insert into
  Pc_Sales_Stg.Dbo.Dim_Product (
    Pc_Make,
    Pc_Model,
    Storage_Type,
    Storage_Capacity,
    Ram
  )
select
  distinct Pc_Make,
  Pc_Model,
  Storage_Type,
  Storage_Capacity,
  Ram
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg
  /*Check whether the table was successfully created*/
select
  *
from
  Pc_Sales_Stg.dbo.Dim_Product