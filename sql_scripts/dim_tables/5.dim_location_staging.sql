/*Drop the initial location dimension without a unique ID*/
DROP TABLE
  pc_sales_stg.dbo.dim_location
  /* Create a new table and insert a unique ID*/
create table
  Pc_Sales_Stg.dbo.dim_location (
    Location_ID INT IDENTITY (1, 1) PRIMARY KEY,
    Continent nvarchar (255) NOT NULL,
    Country_or_State nvarchar (255) NOT NULL,
    Province_or_City nvarchar (255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE ()
  )
  /*Insert data into the location dimension from the staging dataset, use 
   distinct to remove duplicates*/
insert into
  Pc_Sales_Stg.Dbo.Dim_Location (Continent, Country_Or_State, Province_Or_City)
select
  distinct Continent,
  Country_Or_State,
  Province_Or_City
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg
  /*Check whether the table was successfully created*/
select
  *
from
  Pc_Sales_Stg.dbo.Dim_Location