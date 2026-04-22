USE pc_sales_stg
GO

CREATE PROCEDURE sp_create_dim_priority
AS
BEGIN
-- Drop the initial priority dimension  without a unique ID

DROP TABLE [pc_sales_stg].[dbo].[dim_priority]

-- Create a new table and insert a unique ID

CREATE TABLE [pc_sales_stg].[dbo].[dim_priority](
	[Priority_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Priority] [nvarchar](255) NOT NULL,
	[LoadDate] DATETIME DEFAULT GETDATE()
) 

-- Insert data into the priority dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [pc_sales_stg].[dbo].[dim_priority](Priority)
SELECT DISTINCT Priority
FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg]

-- Check whether the table was succesfully created

SELECT * FROM [pc_sales_stg].[dbo].[dim_priority]

END; 

