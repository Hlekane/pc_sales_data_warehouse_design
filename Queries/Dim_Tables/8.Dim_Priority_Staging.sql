-- Drop the initial customer dimension without a unique ID

DROP TABLE [PC_Sales_Stg].[dbo].[Dim_Priority]

-- Create a new table and insert a unique ID, Customer_ID

CREATE TABLE [PC_Sales_Stg].[dbo].[Dim_Priority](
	[Priority_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Priority] [nvarchar](50) NOT NULL
) 

-- Insert data into the customer dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [PC_Sales_Stg].[dbo].[Dim_Priority](Priority)
SELECT DISTINCT Priority
FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

-- Check whether the table was succesfully created

SELECT * FROM [PC_Sales_Stg].[dbo].[Dim_Priority]
