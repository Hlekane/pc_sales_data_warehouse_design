/*Create store procedure to create the dim customer table*/
create Procedure Sp_Create_Dim_Customer as begin
/*drop dim customer if it exists */
drop table
  Pc_Sales_Stg.Dbo.Dim_Customer;


/* Create a new table and insert a unique ID*/
create table
  Pc_Sales_Stg.Dbo.Dim_Customer(
    Customer_Id int Identity(1, 1) Primary Key,
    Customer_Name Nvarchar(255) not null,
    Customer_Surname Nvarchar(255) not null,
    Customer_Contact_Number Nvarchar(255) not null,
    Customer_Email_Address Nvarchar(255) not null,
    LoadDate Datetime default Getdate()
  );


/*Insert data into the customer dimension from the staging dataset, use 
 distinct to remove duplicates*/
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


/*Select the able to see if the insert was correct*/
select
  *
from
  Pc_Sales_Stg.dbo.Dim_Customer
end;