USE pc_sales_stg GO CREATE
OR ALTER Procedure Sp_Create_Pc_Sales_Fact as begin
/* Drop the initial fact table without a unique ID*/
drop table
  Pc_Sales_Stg.Dbo.Pc_Sales_Fact
  /*Create a new table and insert FK*/
create table
  Pc_Sales_Stg.Dbo.Pc_Sales_Fact(
    Pc_Sales_Id int Identity(1, 1) Primary Key,
    Customer_Id int,
    Date_Id int,
    Location_Id int,
    Channel_Id int,
    Payment_Method_Id int,
    Store_Id int,
    Product_Id int,
    Priority_Id int,
    Salesperson_Id int,
    Cost_Price int not null,
    Sale_Price int not null,
    Discount_Amount int not null,
    Finance_Amount Nvarchar(50) not null,
    Credit_Score int not null,
    Cost_Of_Repairs Nvarchar(50) not null,
    Total_Sales_Per_Employee int not null,
    Pc_Market_Price int not null,
    LoadDate Datetime default Getdate()
    /*inserting foreign keys*/
    Constraint Fk_Customer_Id Foreign Key(Customer_Id) References Pc_Sales_Stg.Dbo.Dim_Customer(Customer_Id),
    Constraint Fk_Channel_Id Foreign Key(Channel_Id) References Pc_Sales_Stg.Dbo.Dim_Channel(Channel_Id),
    Constraint Fk_Date_Id Foreign Key(Date_Id) References Pc_Sales_Stg.Dbo.Dim_Date(Date_Id),
    Constraint Fk_Location_Id Foreign Key(Location_Id) References Pc_Sales_Stg.Dbo.Dim_Location(Location_Id),
    Constraint Fk_Payment_Method_Id Foreign Key(Payment_Method_Id) References Pc_Sales_Stg.Dbo.Dim_Payment_Method(Payment_Method_Id),
    Constraint Fk_Store_Id Foreign Key(Store_Id) References Pc_Sales_Stg.Dbo.Dim_Store(Store_Id),
    Constraint Fk_Product_Id Foreign Key(Product_Id) References Pc_Sales_Stg.Dbo.Dim_Product(Product_Id),
    Constraint Fk_Priority_Id Foreign Key(Priority_Id) References Pc_Sales_Stg.Dbo.Dim_Priority(Priority_Id),
    Constraint Fk_Salesperson_Id Foreign Key(Salesperson_Id) References Pc_Sales_Stg.Dbo.Dim_Salesperson(Salesperson_Id)
  );


/* Insert data into the fact table from the staging dataset, use distinct to 
 remove duplicates
 */
insert into
  Pc_Sales_Stg.Dbo.Pc_Sales_Fact (
    Cost_Price,
    Sale_Price,
    Discount_Amount,
    Finance_Amount,
    Credit_Score,
    Cost_Of_Repairs,
    Total_Sales_Per_Employee,
    Pc_Market_Price
  )
select
  Cost_Price,
  Sale_Price,
  Discount_Amount,
  Finance_Amount,
  Credit_Score,
  Cost_Of_Repairs,
  Total_Sales_Per_Employee,
  Pc_Market_Price
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


/*Check whether the table was successfully created*/
select
  *
from
  Pc_Sales_Stg.dbo.Pc_Sales_Fact;


end;