USE pc_sales_stg;
GO
-- Removing duplicated data

-- Location Dim
SELECT DISTINCT 
       [Continent]
      ,[Country_or_State]
      ,[Province_or_City]
    INTO [pc_sales_stg].[dbo].[dim_location]
  FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

  -- Store Dim

SELECT DISTINCT
       [Shop_Name]
      ,[Shop_Age]
     INTO [pc_sales_stg].[dbo].[dim_store]
  FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

-- Product Dim

  SELECT DISTINCT
      [PC_Make]
      ,[PC_Model]
      ,[Storage_Type]
      ,[Storage_Capacity]
      ,[RAM]
     INTO [pc_sales_stg].[dbo].[dim_product]
  FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

-- Customer Dim
SELECT DISTINCT
       [Customer_Name]
      ,[Customer_Surname]
      ,[Customer_Contact_Number]
      ,[Customer_Email_Address]
     INTO [pc_sales_Stg].[dbo].[dim_customer]
  FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

-- Date Dim
 SELECT DISTINCT
       [Purchase_Date]
      ,[Ship_Date]
     INTO [pc_sales_stg].[dbo].[dim_date]
  FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

  -- Salespersons Dim

 SELECT DISTINCT
       [Sales_Person_Name]
      ,[Sales_Person_Department]
     INTO [pc_sales_stg].[dbo].[dim_salesperson]
  FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

-- Payment Dim
  SELECT DISTINCT
       [Payment_Method]
    INTO  [pc_sales_stg].[dbo].[dim_payment_method]
  FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

  -- Channel Dim
    SELECT DISTINCT
      [hannel]
   INTO  [pc_sales_stg].[dbo].[dim_channel]
  FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

  -- Priority Dim 
    SELECT DISTINCT
      [Priority]
   INTO  [pc_sales_stg].[dbo].[dim_priority]
  FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];


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
      INTO [pc_sales_stg].[dbo].[pc_sales_fact]
  FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];
