-- =============================================
-- Script: Create Cleaned Customer Dimension Table
-- Purpose: This script creates a cleaned version of the customer dimension
--          in the data warehouse (pc_sales_dw) by copying and cleaning data
--          from the staging database (pc_sales_stg).
-- Level: Beginner-friendly with detailed explanations
-- =============================================

-- Step 1: Check if the table already exists and drop it if it does
-- This prevents errors if we run the script multiple times
-- OBJECT_ID checks if the table exists, 'U' means it's a user table
IF OBJECT_ID('pc_sales_dw.dbo.dim_customer', 'U') IS NOT NULL
BEGIN
    -- Drop the existing table to recreate it fresh
    DROP TABLE pc_sales_dw.dbo.dim_customer;
    PRINT 'Dropped existing dim_customer table.';
END

-- Step 2: Create the new dimension table in the warehouse
-- This table will store cleaned customer information
CREATE TABLE pc_sales_dw.dbo.dim_customer (
    -- Customer_ID: Unique identifier for each customer (auto-increments)
    Customer_ID INT IDENTITY(1, 1) PRIMARY KEY,

    -- Customer_Name: The customer's first name (required, cleaned)
    Customer_Name NVARCHAR(255) NOT NULL,

    -- Customer_Surname: The customer's last name (required, cleaned)
    Customer_Surname NVARCHAR(255) NOT NULL,

    -- Customer_Contact_Number: Phone number (required, cleaned)
    Customer_Contact_Number NVARCHAR(255) NOT NULL,

    -- Customer_Email_Address: Email address (required, cleaned)
    Customer_Email_Address NVARCHAR(255) NOT NULL,

    -- LoadDate: Timestamp when this record was loaded (auto-set to current date/time)
    LoadDate DATETIME DEFAULT GETDATE()
);

PRINT 'Created new dim_customer table in warehouse.';

-- Step 3: Insert cleaned data from the staging table
-- We copy data from pc_sales_stg.dbo.dim_customer and clean it up
INSERT INTO pc_sales_dw.dbo.dim_customer (
    Customer_Name,
    Customer_Surname,
    Customer_Contact_Number,
    Customer_Email_Address
)
-- SELECT DISTINCT: Get unique combinations only (remove duplicates)
SELECT DISTINCT
    -- TRIM(): Remove extra spaces from the beginning and end
    -- ISNULL(): If the value is NULL, use empty string instead
    TRIM(ISNULL(Customer_Name, '')) AS Customer_Name,
    TRIM(ISNULL(Customer_Surname, '')) AS Customer_Surname,
    TRIM(ISNULL(Customer_Contact_Number, '')) AS Customer_Contact_Number,
    TRIM(ISNULL(Customer_Email_Address, '')) AS Customer_Email_Address

-- FROM: Source table in staging database
FROM pc_sales_stg.dbo.dim_customer

-- WHERE: Only include records where all required fields have actual content
-- LEN(): Check the length after trimming
WHERE LEN(TRIM(ISNULL(Customer_Name, ''))) > 0          -- Name must not be empty
  AND LEN(TRIM(ISNULL(Customer_Surname, ''))) > 0       -- Surname must not be empty
  AND LEN(TRIM(ISNULL(Customer_Contact_Number, ''))) > 0 -- Contact number must not be empty
  AND LEN(TRIM(ISNULL(Customer_Email_Address, ''))) > 0; -- Email must not be empty

PRINT 'Inserted cleaned customer data into warehouse.';

-- Step 4: Validate the data was loaded correctly
-- Count how many records we loaded
SELECT COUNT(*) AS Total_Customers_Loaded
FROM pc_sales_dw.dbo.dim_customer;

PRINT 'Customer dimension table creation completed successfully!';