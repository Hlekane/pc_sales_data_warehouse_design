-- column grouping and data profiling

SELECT [Continent]
      ,[Country_or_State]
      ,[Province_or_City]

FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

SELECT 
      [Shop_Name]
      ,[Shop_Age]

FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

 SELECT
      [PC_Make]
      ,[PC_Model]
      ,[Storage_Type]
      ,[Storage_Capacity]
      ,[RAM]

FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

 SELECT
       [Customer_Name]
      ,[Customer_Surname]
      ,[Customer_Contact_Number]
      ,[Customer_Email_Address]

FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

 SELECT
       [Sales_Person_Name]
      ,[Sales_Person_Department]

FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

 SELECT  
    [Channel]

FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

   SELECT  
       [Purchase_Date]
      ,[Ship_Date]

FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

  SELECT  
       [Priority]

FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

 SELECT 
    [Payment_Method]

 FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

 SELECT 
       [Cost_Price]
      ,[Sale_Price]
      ,[Discount_Amount]
      ,[Finance_Amount]
      ,[Credit_Score]
      ,[Cost_of_Repairs]
      ,[Total_Sales_per_Employee]
      ,[PC_Market_Price]

FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];
