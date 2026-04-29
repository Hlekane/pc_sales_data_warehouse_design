USE pc_sales_stg GO
/*Drop the initial date dimension without a unique ID*/
CREATE
OR ALTER Procedure Sp_Create_Dim_Date as begin
/*Create a new table and insert a unique ID*/
drop table
  Pc_Sales_Stg.Dbo.Dim_Date
create table
  Pc_Sales_Stg.Dbo.Dim_Date(
    Date_Id int Identity(1, 1) Primary Key,
    Purchase_Date Datetime2(7) not null,
    Ship_Date Nvarchar(50) not null,
    LoadDate Datetime default Getdate()
  )
  /* Insert data into the date dimension from the staging dataset, 
   use distinct to remove duplicates*/
insert into
  Pc_Sales_Stg.Dbo.Dim_Date(Purchase_Date, Ship_Date)
select
  distinct Purchase_Date,
  Ship_Date
from
  Pc_Sales_Stg.Dbo.Pc_Sales_Dataset_Stg
select
  *
from
  Pc_Sales_Stg.Dbo.Dim_Date
end;