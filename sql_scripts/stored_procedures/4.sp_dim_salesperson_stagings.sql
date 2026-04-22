USE pc_sales_stg
GO
-- Create SP for dim Salesperson
CREATE PROCEDURE sp_create_dim_salesperson
AS
BEGIN
-- Drop the initial salesperson dimension without a unique ID

DROP TABLE [pc_sales_stg].[dbo].[dim_salesperson]

-- Create a new table and insert a unique ID

CREATE TABLE [pc_sales_stg].[dbo].[dim_salesperson](
	[Salesperson_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Sales_Person_Name] [nvarchar](255) NOT NULL,
	[Sales_Person_Department] [nvarchar](255) NOT NULL,
	[LoadDate] DATETIME DEFAULT GETDATE()
)

-- Insert data into the salesperson dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [pc_sales_stg].[dbo].[dim_salesperson](Sales_Person_Name,Sales_Person_Department)
SELECT DISTINCT Sales_Person_Name,Sales_Person_Department
FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg]

-- Check whether the table was succesfully created

SELECT * FROM [pc_sales_stg].[dbo].[dim_salesperson]
END;

