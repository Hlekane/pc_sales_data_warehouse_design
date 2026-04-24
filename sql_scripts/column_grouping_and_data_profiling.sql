/* column grouping and data profiling*/
select
  Continent,
  Country_Or_State,
  Province_Or_City
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


select
  Shop_Name,
  Shop_Age
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


select
  Pc_Make,
  Pc_Model,
  Storage_Type,
  Storage_Capacity,
  Ram
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


select
  Customer_Name,
  Customer_Surname,
  Customer_Contact_Number,
  Customer_Email_Address
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


select
  Sales_Person_Name,
  Sales_Person_Department
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


select
  Channel
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


select
  Purchase_Date,
  Ship_Date
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


select
  Priority
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


select
  Payment_Method
from
  Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg;


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