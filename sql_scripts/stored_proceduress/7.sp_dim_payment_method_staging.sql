USE pc_sales_stg
GO

CREATE PROCEDURE sp_create_dim_payment_method
AS
BEGIN

-- Drop the initial payment dimension without a unique ID

DROP TABLE [pc_sales_stg].[dbo].[dim_payment_method]

-- Create a new table and insert a unique ID

CREATE TABLE [pc_sales_stg].[dbo].[dim_payment_method](
	[Payment_Method_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Payment_Method] [nvarchar](255) NOT NULL,
	[LoadDate] DATETIME DEFAULT GETDATE()
)

-- Insert data into the payment dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [pc_sales_stg].[dbo].[dim_payment_method](Payment_Method)
SELECT DISTINCT Payment_Method
FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg]

-- Check whether the table was succesfully created

SELECT * FROM [pc_sales_stg].[dbo].[dim_payment_method]

END;


