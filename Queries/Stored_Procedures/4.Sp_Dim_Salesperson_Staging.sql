USE PC_Sales_Stg
GO
-- Create SP for dim Salesperson
CREATE PROCEDURE Sp_Create_Dim_Salesperson
AS
BEGIN
-- Drop the initial salesperson dimension without a unique ID

DROP TABLE [PC_Sales_Stg].[dbo].[Dim_Salesperson]

-- Create a new table and insert a unique ID

CREATE TABLE [PC_Sales_Stg].[dbo].[Dim_Salesperson](
	[Salesperson_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Sales_Person_Name] [nvarchar](255) NOT NULL,
	[Sales_Person_Department] [nvarchar](255) NOT NULL,
	[LoadDate] DATETIME DEFAULT GETDATE()
)

-- Insert data into the salesperson dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [PC_Sales_Stg].[dbo].[Dim_Salesperson](Sales_Person_Name,Sales_Person_Department)
SELECT DISTINCT Sales_Person_Name,Sales_Person_Department
FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

-- Check whether the table was succesfully created

SELECT * FROM [PC_Sales_Stg].[dbo].[Dim_Salesperson]

END;

