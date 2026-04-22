-- Drop the initial location dimension without a unique ID

DROP TABLE [pc_sales_stg].[dbo].[dim_location]

-- Create a new table and insert a unique ID
CREATE TABLE [pc_sales_stg].[dbo].[dim_location](
	[Location_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Continent] [nvarchar](255) NOT NULL,
	[Country_or_State] [nvarchar](255) NOT NULL,
	[Province_or_City] [nvarchar](255) NOT NULL,
	[LoadDate] DATETIME DEFAULT GETDATE()
)


-- Insert data into the location dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [pc_sales_stg].[dbo].[dim_location] (Continent,Country_or_State,Province_or_City)
SELECT DISTINCT Continent,Country_or_State,Province_or_City
FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg]

-- Check whether the table was succesfully created

SELECT * FROM [pc_sales_stg].[dbo].[dim_location]

