-- Drop the initial customer dimension without a unique ID

DROP TABLE [PC_Sales_Stg].[dbo].[Dim_Location]

-- Create a new table and insert a unique ID, Customer_ID

CREATE TABLE [PC_Sales_Stg].[dbo].[Dim_Location](
	[Location_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Continent] [nvarchar](255) NOT NULL,
	[Country_or_State] [nvarchar](255) NOT NULL,
	[Province_or_City] [nvarchar](255) NOT NULL
)


-- Insert data into the customer dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [PC_Sales_Stg].[dbo].[Dim_Location] (Continent,Country_or_State,Province_or_City)
SELECT DISTINCT Continent,Country_or_State,Province_or_City
FROM [PC_Sales_Stg].[dbo].[PC_sales_dataset_Stg]

-- Check whether the table was succesfully created

SELECT * FROM [PC_Sales_Stg].[dbo].[Dim_Location]

