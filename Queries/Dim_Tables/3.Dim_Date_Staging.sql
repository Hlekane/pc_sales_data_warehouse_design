-- Create table if it does not exist

DROP TABLE [PC_Sales_Stg].[dbo].[Dim_Date]
-- Create table if it does not exist

CREATE TABLE [PC_Sales_Stg].[dbo].[Dim_Date](
	[Date_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Purchase_Date] [datetime2](7) NOT NULL,
	[Ship_Date] [nvarchar](50) NOT NULL
) 
-- Insert data into the customer dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [PC_Sales_Stg].[dbo].[Dim_Date] (Purchase_Date,Ship_Date)
SELECT DISTINCT Purchase_Date,Ship_Date
FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

-- Check whether the table was succesfully created

SELECT * FROM [PC_Sales_Stg].[dbo].[Dim_Date]