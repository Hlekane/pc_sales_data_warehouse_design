-- Create store procedure to create the dim customer table
CREATE PROCEDURE Sp_Create_Dim_Customer
AS
BEGIN

-- drop dim customer if it exists
DROP TABLE [PC_Sales_Stg].[dbo].[Dim_Customer];

-- Create a new table and insert a unique ID

CREATE TABLE [PC_Sales_Stg].[dbo].[Dim_Customer](
	[Customer_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Customer_Name] [nvarchar](255) NOT NULL,
	[Customer_Surname] [nvarchar](255) NOT NULL,
	[Customer_Contact_Number] [nvarchar](255) NOT NULL,
	[Customer_Email_Address] [nvarchar](255) NOT NULL,
	[LoadDate] DATETIME DEFAULT GETDATE()
);

-- Insert data into the customer dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [PC_Sales_Stg].[dbo].[Dim_Customer] (Customer_Name, Customer_Surname, Customer_Contact_Number, Customer_Email_Address)
SELECT DISTINCT Customer_Name, Customer_Surname, Customer_Contact_Number, Customer_Email_Address
FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg];

-- Select the able to see if the insertwascorrect
SELECT * FROM [PC_Sales_Stg].[dbo].[Dim_Customer]

END;




