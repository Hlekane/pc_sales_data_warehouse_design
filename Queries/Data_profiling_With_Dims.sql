USE PC_Sales_Stg;
GO
-- Removing duplicated data

-- Location Dim
SELECT DISTINCT 
       [Continent]
      ,[Country_or_State]
      ,[Province_or_City]
    INTO [PC_Sales_Stg].[dbo].[Dim_Location]
  FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg];

  -- Store Dim

SELECT DISTINCT
       [Shop_Name]
      ,[Shop_Age]
     INTO [PC_Sales_Stg].[dbo].[Dim_Store]
  FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

-- Product Dim

  SELECT DISTINCT
      [PC_Make]
      ,[PC_Model]
      ,[Storage_Type]
      ,[Storage_Capacity]
      ,[RAM]
     INTO [PC_Sales_Stg].[dbo].[Dim_Product]
  FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

-- Customer Dim
SELECT DISTINCT
       [Customer_Name]
      ,[Customer_Surname]
      ,[Customer_Contact_Number]
      ,[Customer_Email_Address]
     INTO [PC_Sales_Stg].[dbo].[Dim_Customer]
  FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

-- Date Dim
 SELECT DISTINCT
       [Purchase_Date]
      ,[Ship_Date]
     INTO [PC_Sales_Stg].[dbo].[Dim_Date]
  FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

  -- Salespersons Dim

 SELECT DISTINCT
       [Sales_Person_Name]
      ,[Sales_Person_Department]
     INTO [PC_Sales_Stg].[dbo].[Dim_Salesperson]
  FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

-- Payment Dim
  SELECT DISTINCT
       [Payment_Method]
    INTO  [PC_Sales_Stg].[dbo].[Dim_Payment_Method]
  FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

  -- Channel Dim
    SELECT DISTINCT
      [Channel]
   INTO  [PC_Sales_Stg].[dbo].[Dim_Channel]
  FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

  -- Priority Dim 
    SELECT DISTINCT
      [Priority]
   INTO  [PC_Sales_Stg].[dbo].[Dim_Priority]
  FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]


  -- PC_Sales Fact Table
 SELECT DISTINCT
       [Cost_Price]
      ,[Sale_Price]
      ,[Discount_Amount]
      ,[Finance_Amount]
      ,[Credit_Score]
      ,[Cost_of_Repairs]
      ,[Total_Sales_per_Employee]
      ,[PC_Market_Price]
      INTO [PC_Sales_Stg].[dbo].[PC_Sales_Fact]
  FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]; 
