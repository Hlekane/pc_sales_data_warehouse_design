USE pc_sales_stg GO
/*Create SP for dim Salesperson*/
CREATE
OR ALTER Procedure Sp_Create_Dim_Salesperson as begin
/*Drop the initial salesperson dimension without a unique ID */
drop table
  Pc_Sales_Stg.Dbo.Dim_Salesperson
  /*Create a new table and insert a unique ID*/
create table
  Pc_Sales_Stg.Dbo.Dim_Salesperson(
    Salesperson_Id int Identity(1, 1) Primary Key,
    Sales_Person_Name Nvarchar(255) not null,
    Sales_Person_Department Nvarchar(255) not null,
    LoadDate Datetime default Getdate()
  )
  /*Insert data into the salesperson dimension from the staging dataset, use 
   distinct to remove duplicates*/
insert into
  Pc_Sales_Stg.Dbo.Dim_Salesperson(Sales_Person_Name, Sales_Person_Department)
select
  distinct Sales_Person_Name,
  Sales_Person_Department
from
  Pc_Sales_Stg.Dbo.Pc_Sales_Dataset_Stg
  /*Check whether the table was successfully created*/
select
  *
from
  Pc_Sales_Stg.Dbo.Dim_Salesperson
end;