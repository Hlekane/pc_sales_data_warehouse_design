USE pc_sales_stg GO CREATE
OR ALTER Procedure Sp_Create_Dim_Payment_Method as begin
/*Drop the initial payment dimension without a unique ID*/
drop table
  Pc_Sales_Stg.Dbo.Dim_Payment_Method
  /* Create a new table and insert a unique ID*/
create table
  Pc_Sales_Stg.Dbo.Dim_Payment_Method(
    Payment_Method_Id int Identity(1, 1) Primary Key,
    Payment_Method Nvarchar(255) not null,
    LoadDate Datetime default Getdate()
  )
  /*Insert data into the payment dimension from the staging dataset, use 
   distinct to remove duplicates*/
insert into
  Pc_Sales_Stg.Dbo.Dim_Payment_Method(Payment_Method)
select
  distinct Payment_Method
from
  Pc_Sales_Stg.Dbo.Pc_Sales_Dataset_Stg
  /*Check whether the table was successfully created*/
select
  *
from
  Pc_Sales_Stg.Dbo.Dim_Payment_Method
end;