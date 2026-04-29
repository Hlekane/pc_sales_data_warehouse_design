USE pc_sales_stg GO CREATE OR ALTER Procedure Sp_Create_Dim_Priority as begin
/*Drop the initial priority dimension  without a unique ID*/
drop table
  Pc_Sales_Stg.Dbo.Dim_Priority
  /*Create a new table and insert a unique ID*/
create table
  Pc_Sales_Stg.Dbo.Dim_Priority(
    Priority_Id int Identity(1, 1) Primary Key,
    Priority Nvarchar(255) not null,
    LoadDate Datetime default Getdate()
  )
  /*Insert data into the priority dimension from the staging dataset, use 
   distinct to remove duplicates*/
insert into
  Pc_Sales_Stg.Dbo.Dim_Priority(Priority)
select
  distinct Priority
from
  Pc_Sales_Stg.Dbo.Pc_Sales_Dataset_Stg
  /*Check whether the table was successfully created*/
select
  *
from
  Pc_Sales_Stg.Dbo.Dim_Priority
end;