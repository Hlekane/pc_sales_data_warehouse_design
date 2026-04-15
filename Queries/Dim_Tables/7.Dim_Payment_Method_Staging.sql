-- Drop the initial customer dimension without a unique ID

DROP TABLE [PC_Sales_Stg].[dbo].[Dim_Payment_Method]

-- Create a new table and insert a unique ID, Customer_ID

CREATE TABLE [PC_Sales_Stg].[dbo].[Dim_Payment_Method](
	[Payment_Method_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Payment_Method] [nvarchar](255) NOT NULL
)

-- Insert data into the customer dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [PC_Sales_Stg].[dbo].[Dim_Payment_Method](Payment_Method)
SELECT DISTINCT Payment_Method
FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

-- Check whether the table was succesfully created

SELECT * FROM [PC_Sales_Stg].[dbo].[Dim_Payment_Method]
