USE pc_sales_stg;


GO
/* Removing duplicated data*/
/* Location Dim*/
select
  distinct Continent,
  Country_Or_State,
  Province_Or_City into Pc_Sales_Stg.Dbo.Dim_Location
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


/* Store Dim*/
select
  distinct Shop_Name,
  Shop_Age into Pc_Sales_Stg.Dbo.Dim_Store
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


/* Product Dim*/
select
  distinct Pc_Make,
  Pc_Model,
  Storage_Type,
  Storage_Capacity,
  Ram into Pc_Sales_Stg.Dbo.Dim_Product
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


/*Customer Dim*/
select
  distinct Customer_Name,
  Customer_Surname,
  Customer_Contact_Number,
  Customer_Email_Address into Pc_Sales_Stg.Dbo.Dim_Customer
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


/*Date Dim*/
select
  distinct Purchase_Date,
  Ship_Date into Pc_Sales_Stg.Dbo.Dim_Date
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


/*Salespersons Dim*/
select
  distinct Sales_Person_Name,
  Sales_Person_Department into Pc_Sales_Stg.Dbo.Dim_Salesperson
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


/* Payment Dim*/
select
  distinct Payment_Method into Pc_Sales_Stg.Dbo.Dim_Payment_Method
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


/*Channel Dim*/
select
  distinct Hannel into Pc_Sales_Stg.Dbo.Dim_Channel
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


/*Priority Dim */
select
  distinct Priority into Pc_Sales_Stg.Dbo.Dim_Priority
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


/* PC_Sales Fact Table*/
select
  distinct Cost_Price,
  Sale_Price,
  Discount_Amount,
  Finance_Amount,
  Credit_Score,
  Cost_Of_Repairs,
  Total_Sales_Per_Employee,
  Pc_Market_Price into Pc_Sales_Stg.Dbo.Pc_Sales_Fact
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;