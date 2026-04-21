USE PC_Sales_Stg
GO

CREATE PROCEDURE Sp_Create_Dim_Priority
AS
BEGIN
-- Drop the initial priority dimension  without a unique ID

DROP TABLE [PC_Sales_Stg].[dbo].[Dim_Priority]

-- Create a new table and insert a unique ID

CREATE TABLE [PC_Sales_Stg].[dbo].[Dim_Priority](
	[Priority_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Priority] [nvarchar](255) NOT NULL,
	[LoadDate] DATETIME DEFAULT GETDATE()
) 

-- Insert data into the priority dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [PC_Sales_Stg].[dbo].[Dim_Priority](Priority)
SELECT DISTINCT Priority
FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

-- Check whether the table was succesfully created

SELECT * FROM [PC_Sales_Stg].[dbo].[Dim_Priority]

END; 

