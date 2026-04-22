
-- Drop the initial channel dimension without a unique ID

DROP TABLE [pc_sales_stg].[dbo].[dim_channel]

-- Create a new table and insert a unique ID

CREATE TABLE [pc_sales_stg].[dbo].[dim_channel](
	[Channel_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Channel] [nvarchar](255) NOT NULL,
	[LoadDate] DATETIME DEFAULT GETDATE()
) 

-- Insert data into the channel dimension from the staging dataset, use distinct to remove duplicates

INSERT INTO [pc_sales_stg].[dbo].[dim_channel] (Channel)
SELECT DISTINCT Channel
FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg]

-- Check whether the table was succesfully created

SELECT * FROM [pc_sales_stg].[dbo].[dim_channel]
