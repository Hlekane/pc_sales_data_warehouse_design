USE PC_Sales_Stg
GO

CREATE PROCEDURE Sp_Create_Dim_Channel
AS
BEGIN
-- Drop the initial channel dimension without a unique ID

DROP TABLE [PC_Sales_Stg].[dbo].[Dim_Channel]

-- Create a new table and insert a unique ID

CREATE TABLE [PC_Sales_Stg].[dbo].[Dim_Channel](
	[Channel_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Channel] [nvarchar](255) NOT NULL,
	[LoadDate] DATETIME DEFAULT GETDATE()
) 

-- Insert data into the channel dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO[PC_Sales_Stg].[dbo].[Dim_Channel] (Channel)
SELECT DISTINCT Channel
FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

-- Check whether the table was succesfully created

SELECT * FROM [PC_Sales_Stg].[dbo].[Dim_Channel]

END;

