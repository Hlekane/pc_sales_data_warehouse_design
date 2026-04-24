/* drop dim customer if it exists*/
DROP TABLE
  pc_sales_stg.dbo.dim_customer;


/*Create a new table and insert a unique ID*/
create table
  Pc_Sales_Stg.dbo.dim_customer (
    Customer_ID INT IDENTITY (1, 1) PRIMARY KEY,
    Customer_Name nvarchar (255) NOT NULL,
    Customer_Surname nvarchar (255) NOT NULL,
    Customer_Contact_Number nvarchar (255) NOT NULL,
    Customer_Email_Address nvarchar (255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE ()
  );


/* Insert data into the customer dimension from the staging dataset, 
 use distinct to remove duplicates*/
insert into
  Pc_Sales_Stg.Dbo.Dim_Customer (
    Customer_Name,
    Customer_Surname,
    Customer_Contact_Number,
    Customer_Email_Address
  )
select
  distinct Customer_Name,
  Customer_Surname,
  Customer_Contact_Number,
  Customer_Email_Address
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


/* Select the table to see if the insert was correct*/
select
  *
from
  Pc_Sales_Stg.dbo.Dim_Customer;