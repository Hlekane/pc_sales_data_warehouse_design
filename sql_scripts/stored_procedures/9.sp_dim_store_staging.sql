USE pc_sales_stg GO CREATE OR ALTER Procedure Sp_Create_Dim_Store as begin
/*Drop the initial store dimension without a unique ID*/
drop table
  Pc_Sales_Stg.Dbo.Dim_Store
  /*Create a new table and insert a unique ID*/
create table
  Pc_Sales_Stg.Dbo.Dim_Store(
    Store_Id int Identity(1, 1) Primary Key,
    Shop_Name Nvarchar(255) not null,
    Shop_Age Nvarchar(255) not null,
    LoadDate Datetime default Getdate()
  )
  /*Insert data into the store dimension from the staging dataset, use distinct to 
   remove duplicates*/
insert into
  Pc_Sales_Stg.Dbo.Dim_Store(Shop_Name, Shop_Age)
select
  distinct Shop_Name,
  Shop_Age
from
  Pc_Sales_Stg.Dbo.Pc_Sales_Dataset_Stg
  /* Check whether the table was successfully created*/
select
  *
from
  Pc_Sales_Stg.Dbo.Dim_Store
end;