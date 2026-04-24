USE pc_sales_stg GO create Procedure Sp_Create_Dim_Location as begin
/*Drop the initial location dimension without a unique ID*/
drop table
  Pc_Sales_Stg.Dbo.Dim_Location
  /*Create a new table and insert a unique ID*/
create table
  Pc_Sales_Stg.Dbo.Dim_Location(
    Location_Id int Identity(1, 1) Primary Key,
    Continent Nvarchar(255) not null,
    Country_Or_State Nvarchar(255) not null,
    Province_Or_City Nvarchar(255) not null,
    LoadDate Datetime default Getdate()
  )
  /*Insert data into the location dimension from the staging dataset, 
   use distinct to remove duplicates*/
insert into
  Pc_Sales_Stg.Dbo.Dim_Location(Continent, Country_Or_State, Province_Or_City)
select
  distinct Continent,
  Country_Or_State,
  Province_Or_City
from
  Pc_Sales_Stg.Dbo.Pc_Sales_Dataset_Stg
  /*Check whether the table was successfully created*/
select
  *
from
  Pc_Sales_Stg.Dbo.Dim_Location
end;