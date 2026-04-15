
-- Drop table if it exist

DROP TABLE [PC_Sales_Stg].[dbo].[Dim_Customer];

-- Create table if it does not exist

CREATE TABLE [PC_Sales_Stg].[dbo].[Dim_Customer](
	[Customer_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Customer_Name] [nvarchar](255) NOT NULL,
	[Customer_Surname] [nvarchar](255) NOT NULL,
	[Customer_Contact_Number] [nvarchar](255) NOT NULL,
	[Customer_Email_Address] [nvarchar](255) NOT NULL
);

-- Insert data into the customer dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [PC_Sales_Stg].[dbo].[Dim_Customer] (Customer_Name, Customer_Surname, Customer_Contact_Number, Customer_Email_Address)
SELECT DISTINCT Customer_Name, Customer_Surname, Customer_Contact_Number, Customer_Email_Address
FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg];

-- Check whether the table was succesfully selected

SELECT * FROM [PC_Sales_Stg].[dbo].[Dim_Customer];