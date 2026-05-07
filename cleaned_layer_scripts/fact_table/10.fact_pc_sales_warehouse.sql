-- =============================================
-- Script: Create Cleaned PC Sales Fact Table
-- Purpose: This script creates the main fact table in the data warehouse
--          by joining cleaned dimension tables with validated staging data.
--          The fact table stores measurable sales transaction data.
-- Level: Beginner-friendly with detailed explanations
-- =============================================

-- Step 1: Check if the fact table already exists and drop it if it does
-- This prevents errors if we run the script multiple times
IF OBJECT_ID('pc_sales_dw.dbo.fact_pc_sales', 'U') IS NOT NULL
BEGIN
    -- Drop the existing table to recreate it fresh
    DROP TABLE pc_sales_dw.dbo.fact_pc_sales;
    PRINT 'Dropped existing fact_pc_sales table.';
END

-- Step 2: Create the fact table structure
-- Fact tables store the "facts" or measurements of business processes
-- Each row represents one PC sales transaction
CREATE TABLE pc_sales_dw.dbo.fact_pc_sales (
    -- PC_Sales_ID: Unique identifier for each sales transaction (auto-increments)
    PC_Sales_ID INT IDENTITY(1, 1) PRIMARY KEY,

    -- Foreign Keys: Links to dimension tables (references the IDs from dims)
    Channel_ID INT NOT NULL,        -- Links to dim_channel
    Customer_ID INT NOT NULL,       -- Links to dim_customer
    Date_ID INT NOT NULL,           -- Links to dim_date
    Store_ID INT NOT NULL,          -- Links to dim_store
    Priority_ID INT NOT NULL,       -- Links to dim_priority
    Salesperson_ID INT NOT NULL,    -- Links to dim_salesperson
    Location_ID INT NOT NULL,       -- Links to dim_location
    Payment_Method_ID INT NOT NULL, -- Links to dim_payment_method
    Product_ID INT NOT NULL,        -- Links to dim_product

    -- Measurable Facts: The actual sales data (numbers we can analyze)
    Cost_Price DECIMAL(10, 2) NOT NULL,           -- What the PC cost to buy
    Sale_Price DECIMAL(10, 2) NOT NULL,           -- What the customer paid
    Discount_Amount DECIMAL(10, 2) NOT NULL,      -- Any discount given
    Finance_Amount DECIMAL(10, 2) NOT NULL,       -- Financing amount
    Cost_of_Repairs DECIMAL(10, 2) NOT NULL,      -- Repair costs
    Total_Sales_per_Employee DECIMAL(10, 2) NOT NULL, -- Employee sales total
    PC_Market_Price DECIMAL(10, 2) NOT NULL,      -- Market value of PC
    Credit_Score INT NOT NULL,                    -- Customer's credit score

    -- LoadDate: When this fact record was loaded into warehouse
    LoadDate DATETIME DEFAULT GETDATE()
);

PRINT 'Created new fact_pc_sales table in warehouse.';

-- Step 3: Insert data by joining staging data with cleaned dimensions
-- This is the most complex part - we link the raw sales data to our clean dimensions
INSERT INTO pc_sales_dw.dbo.fact_pc_sales (
    Channel_ID,
    Customer_ID,
    Date_ID,
    Store_ID,
    Priority_ID,
    Salesperson_ID,
    Location_ID,
    Payment_Method_ID,
    Product_ID,
    Cost_Price,
    Sale_Price,
    Discount_Amount,
    Finance_Amount,
    Cost_of_Repairs,
    Total_Sales_per_Employee,
    PC_Market_Price,
    Credit_Score
)
SELECT
    -- Get the dimension IDs by matching the staging data to dimension tables
    ch.Channel_ID,
    c.Customer_ID,
    d.Date_ID,
    s.Store_ID,
    pr.Priority_ID,
    sp.Salesperson_ID,
    l.Location_ID,
    pm.Payment_Method_ID,
    p.Product_ID,

    -- Copy the numeric facts directly from staging (they're already validated)
    std.Cost_Price,
    std.Sale_Price,
    std.Discount_Amount,
    std.Finance_Amount,
    std.Cost_of_Repairs,
    std.Total_Sales_per_Employee,
    std.PC_Market_Price,
    std.Credit_Score

-- FROM: Start with the raw staging data table
FROM pc_sales_stg.dbo.pc_sales_dataset_stg AS std

-- INNER JOIN: Only include records that have matching dimension records
-- This ensures data quality - no "orphaned" facts without dimensions

-- Join to Channel dimension
INNER JOIN pc_sales_dw.dbo.dim_channel ch
    ON TRIM(ISNULL(std.Channel, '')) = ch.Channel

-- Join to Customer dimension (matches on multiple fields for uniqueness)
INNER JOIN pc_sales_dw.dbo.dim_customer c
    ON TRIM(ISNULL(std.Customer_Name, '')) = c.Customer_Name
    AND TRIM(ISNULL(std.Customer_Surname, '')) = c.Customer_Surname
    AND TRIM(ISNULL(std.Customer_Contact_Number, '')) = c.Customer_Contact_Number
    AND TRIM(ISNULL(std.Customer_Email_Address, '')) = c.Customer_Email_Address

-- Join to Date dimension
INNER JOIN pc_sales_dw.dbo.dim_date d
    ON std.Purchase_Date = d.Purchase_Date
    AND TRIM(ISNULL(std.Ship_Date, '')) = d.Ship_Date

-- Join to Store dimension
INNER JOIN pc_sales_dw.dbo.dim_store s
    ON TRIM(ISNULL(std.Shop_Name, '')) = s.Shop_Name
    AND TRIM(ISNULL(std.Shop_Age, '')) = s.Shop_Age

-- Join to Priority dimension
INNER JOIN pc_sales_dw.dbo.dim_priority pr
    ON TRIM(ISNULL(std.Priority, '')) = pr.Priority

-- Join to Salesperson dimension
INNER JOIN pc_sales_dw.dbo.dim_salesperson sp
    ON TRIM(ISNULL(std.Sales_Person_Name, '')) = sp.Sales_Person_Name
    AND TRIM(ISNULL(std.Sales_Person_Department, '')) = sp.Sales_Person_Department

-- Join to Location dimension
INNER JOIN pc_sales_dw.dbo.dim_location l
    ON TRIM(ISNULL(std.Continent, '')) = l.Continent
    AND TRIM(ISNULL(std.Country_Or_State, '')) = l.Country_Or_State
    AND TRIM(ISNULL(std.Province_Or_City, '')) = l.Province_Or_City

-- Join to Payment Method dimension
INNER JOIN pc_sales_dw.dbo.dim_payment_method pm
    ON TRIM(ISNULL(std.Payment_Method, '')) = pm.Payment_Method

-- Join to Product dimension (matches on multiple technical specs)
INNER JOIN pc_sales_dw.dbo.dim_product p
    ON TRIM(ISNULL(std.PC_Model, '')) = p.PC_Model
    AND TRIM(ISNULL(std.PC_Make, '')) = p.PC_Make
    AND TRIM(ISNULL(std.Storage_Capacity, '')) = p.Storage_Capacity
    AND TRIM(ISNULL(std.Storage_Type, '')) = p.Storage_Type
    AND TRIM(ISNULL(std.RAM, '')) = p.RAM

-- WHERE: Additional validation - only include records with valid numeric data
WHERE std.Cost_Price >= 0              -- Cost can't be negative
  AND std.Sale_Price >= 0              -- Sale price can't be negative
  AND std.Discount_Amount >= 0         -- Discount can't be negative
  AND std.Finance_Amount >= 0          -- Finance amount can't be negative
  AND std.Cost_of_Repairs >= 0         -- Repair cost can't be negative
  AND std.Total_Sales_per_Employee >= 0 -- Employee sales can't be negative
  AND std.PC_Market_Price >= 0         -- Market price can't be negative
  AND std.Credit_Score >= 0;           -- Credit score can't be negative

PRINT 'Inserted cleaned fact data into warehouse.';

-- Step 4: Validate the data was loaded correctly
-- Count how many fact records we loaded
SELECT COUNT(*) AS Total_Fact_Records_Loaded
FROM pc_sales_dw.dbo.fact_pc_sales;

PRINT 'Fact table creation completed successfully!';
PRINT 'The data warehouse is now ready for analysis and reporting.';