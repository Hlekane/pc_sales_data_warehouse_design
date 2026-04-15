-- Drop the initial customer dimension without a unique ID

DROP TABLE [PC_Sales_Stg].[dbo].[Dim_Store]

-- Create a new table and insert a unique ID, Customer_ID

CREATE TABLE [PC_Sales_Stg].[dbo].[Dim_Store](
	[Store_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Shop_Name] [nvarchar](50) NOT NULL,
	[Shop_Age] [nvarchar](50) NOT NULL
)

-- Insert data into the customer dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [PC_Sales_Stg].[dbo].[Dim_Store](Shop_Name,Shop_Age)
SELECT DISTINCT Shop_Name,Shop_Age
FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

-- Check whether the table was succesfully created

SELECT * FROM [PC_Sales_Stg].[dbo].[Dim_Store]