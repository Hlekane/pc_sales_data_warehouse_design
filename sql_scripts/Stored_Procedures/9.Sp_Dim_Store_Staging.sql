USE pc_sales_stg
GO

CREATE PROCEDURE sp_create_dim_store
AS
BEGIN

-- Drop the initial store dimension without a unique ID

DROP TABLE [pc_sales_Stg].[dbo].[dim_store]

-- Create a new table and insert a unique ID

CREATE TABLE [pc_sales_Stg].[dbo].[dim_store](
	[Store_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Shop_Name] [nvarchar](255) NOT NULL,
	[Shop_Age] [nvarchar](255) NOT NULL,
	[LoadDate] DATETIME DEFAULT GETDATE()
)

-- Insert data into the store dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [pc_Sales_Stg].[dbo].[dim_store](Shop_Name,Shop_Age)
SELECT DISTINCT Shop_Name,Shop_Age
FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg]

-- Check whether the table was succesfully created

SELECT * FROM [pc_sales_Stg].[dbo].[dim_store]

END;

