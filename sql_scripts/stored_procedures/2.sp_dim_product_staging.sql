USE pc_sales_stg GO
/* Create the SP for the dim product*/
CREATE OR ALTER Procedure Sp_Create_Dim_Product as begin
/*Drop the initial product dimension without a unique ID */
drop table
  Pc_Sales_Stg.Dbo.Dim_Product
  /*Create a new table and insert a unique ID */
create table
  Pc_Sales_Stg.Dbo.Dim_Product(
    Product_Id int Identity(1, 1) Primary Key,
    Pc_Make Nvarchar(255) not null,
    Pc_Model Nvarchar(255) not null,
    Storage_Type Nvarchar(255) not null,
    Storage_Capacity Nvarchar(255) not null,
    Ram Nvarchar(255) not null,
    LoadDate Datetime default Getdate()
  )
  /*Insert data into the product dimension from the staging dataset, 
   use distinct to remove duplicates*/
  --
insert into
  Pc_Sales_Stg.Dbo.Dim_Product(
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
  Pc_Sales_Stg.Dbo.Pc_Sales_Dataset_Stg;


/*Check whether the table was successfully created*/
--
select
  *
from
  Pc_Sales_Stg.dbo.Dim_Product
end;