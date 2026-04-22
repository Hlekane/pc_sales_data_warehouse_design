USE pc_sales_stg
GO
-- Create the SP for the dim product
CREATE PROCEDURE sp_create_dim_product
AS
BEGIN
-- Drop the initial product dimension without a unique ID
DROP TABLE [pc_sales_stg].[dbo].[dim_product]

-- Create a new table and insert a unique ID
CREATE TABLE [pc_sales_stg].[dbo].[dim_product](
	[Product_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[PC_Make] [nvarchar](255) NOT NULL,
	[PC_Model] [nvarchar](255) NOT NULL,
	[Storage_Type] [nvarchar](255) NOT NULL,
	[Storage_Capacity] [nvarchar](255) NOT NULL,
	[RAM] [nvarchar](255) NOT NULL,
	[LoadDate] DATETIME DEFAULT GETDATE()
)

-- Insert data into the product dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [pc_sales_stg].[dbo].[dim_product](PC_Make,PC_Model,Storage_Type,Storage_Capacity,RAM)
SELECT DISTINCT PC_Make,PC_Model,Storage_Type,Storage_Capacity,RAM
FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

-- Check whether the table was succesfully created

SELECT * FROM [pc_sales_stg].[dbo].[dim_product]

END;

