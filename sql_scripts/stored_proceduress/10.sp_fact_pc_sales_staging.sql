USE pc_sales_stg
GO

CREATE PROCEDURE sp_create_pc_sales_fact
AS
BEGIN
-- Drop the initial fact table without a unique ID

DROP TABLE [pc_sales_stg].[dbo].[pc_sales_fact]

-- Create a new table and insert FK

CREATE TABLE [pc_sales_stg].[dbo].[pc_sales_fact](
	[PC_Sales_ID] INT IDENTITY (1,1) PRIMARY KEY,
	[Customer_ID] [int],
	[Date_ID] [int],
	[Location_ID] [int],
	[Channel_ID] [int],
	[Payment_Method_ID] [int],
	[Store_ID] [int],
	[Product_ID] [Int],
	[Priority_ID] [Int],
	[Salesperson_ID] [Int],
	[Cost_Price] [int] NOT NULL,
	[Sale_Price] [int] NOT NULL,
	[Discount_Amount] [int] NOT NULL,
	[Finance_Amount] [nvarchar](50) NOT NULL,
	[Credit_Score] [int] NOT NULL,
	[Cost_of_Repairs] [nvarchar](50) NOT NULL,
	[Total_Sales_per_Employee] [int] NOT NULL,
	[PC_Market_Price] [int] NOT NULL,
	[LoadDate] DATETIME DEFAULT GETDATE()

	-- inserting foreign keys
	Constraint fk_Customer_ID
			Foreign key (Customer_ID)
			References [pc_sales_stg].[dbo].[dim_customer] (Customer_ID),
	Constraint fk_Channel_ID
			Foreign key (Channel_ID)
			References [pc_sales_stg].[dbo].[dim_channel] (Channel_ID),
	Constraint fk_Date_ID
			Foreign key (Date_ID)
			References [pc_sales_stg].[dbo].[dim_date] (Date_ID),
	Constraint fk_Location_ID
			Foreign key (Location_ID)
			References [pc_sales_stg].[dbo].[dim_location] (Location_ID),
	Constraint fk_Payment_Method_ID
			Foreign key (Payment_Method_ID)
			References [pc_sales_stg].[dbo].[dim_payment_method] (Payment_Method_ID),
	Constraint fk_Store_ID
			Foreign key (Store_ID)
			References [pc_sales_stg].[dbo].[dim_store] (Store_ID),
	Constraint fk_Product_ID
			Foreign key (Product_ID)
			References [pc_sales_stg].[dbo].[dim_product] (Product_ID),
	Constraint fk_Priority_ID
			Foreign key (Priority_ID)
			References [pc_sales_stg].[dbo].[dim_priority] (Priority_ID),
	Constraint fk_Salesperson_ID
			Foreign key (Salesperson_ID)
			References [pc_sales_Stg].[dbo].[dim_salesperson] (Salesperson_ID),
);

-- Insert data into the fact table from the staging dataset, use distinct to remove duplicates

INSERT INTO [pc_sales_stg].[dbo].[pc_sales_fact](Cost_Price,Sale_Price,Discount_Amount,Finance_Amount,Credit_Score,Cost_of_Repairs,Total_Sales_per_Employee,PC_Market_Price)
SELECT Cost_Price,Sale_Price,Discount_Amount,Finance_Amount,Credit_Score,Cost_of_Repairs,Total_Sales_per_Employee,PC_Market_Price
FROM [pc_sales_stg].[dbo].[pc_sales_dataset_stg];

-- Check whether the table was succesfully created
SELECT * FROM [pc_sales_stg].[dbo].[pc_sales_fact];

END;

