/*Drop the initial channel dimension without a unique ID*/
DROP TABLE
  pc_sales_stg.dbo.dim_channel
  /*Create a new table and insert a unique ID*/
create table
  Pc_Sales_Stg.dbo.dim_channel (
    Channel_ID INT IDENTITY (1, 1) PRIMARY KEY,
    Channel nvarchar (255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE ()
  )
  /* Insert data into the channel dimension from the staging dataset, 
   use distinct to remove duplicates */
insert into
  Pc_Sales_Stg.Dbo.Dim_Channel (Channel)
select
  distinct Channel
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg
  /*Check whether the table was successfully created */
select
  *
from
  Pc_Sales_Stg.dbo.Dim_Channel