-- =============================================
-- Script: Data Quality Checks for Warehouse
-- Purpose: This script runs various checks to ensure the data
--          loaded into the warehouse is clean and valid.
-- =============================================

PRINT 'Starting data quality checks for the warehouse...';

-- =============================================
-- Check 1: Row Counts - How many records in each table?
-- =============================================
PRINT '=== ROW COUNT SUMMARY ===';
PRINT 'This shows how many records were loaded into each table:';

SELECT 'dim_customer' AS Table_Name, COUNT(*) AS Row_Count FROM pc_sales_dw.dbo.dim_customer
UNION ALL
SELECT 'dim_product', COUNT(*) FROM pc_sales_dw.dbo.dim_product
UNION ALL
SELECT 'dim_date', COUNT(*) FROM pc_sales_dw.dbo.dim_date
UNION ALL
SELECT 'dim_salesperson', COUNT(*) FROM pc_sales_dw.dbo.dim_salesperson
UNION ALL
SELECT 'dim_location', COUNT(*) FROM pc_sales_dw.dbo.dim_location
UNION ALL
SELECT 'dim_channel', COUNT(*) FROM pc_sales_dw.dbo.dim_channel
UNION ALL
SELECT 'dim_payment_method', COUNT(*) FROM pc_sales_dw.dbo.dim_payment_method
UNION ALL
SELECT 'dim_priority', COUNT(*) FROM pc_sales_dw.dbo.dim_priority
UNION ALL
SELECT 'dim_store', COUNT(*) FROM pc_sales_dw.dbo.dim_store
UNION ALL
SELECT 'fact_pc_sales', COUNT(*) FROM pc_sales_dw.dbo.fact_pc_sales;

PRINT 'If any table has 0 rows, there might be an issue with the loading process.';
PRINT '';

-- =============================================
-- Check 2: NULL Values in Fact Table Foreign Keys
-- =============================================
PRINT '=== NULL CHECKS IN FACT TABLE ===';
PRINT 'Checking for NULL values in foreign key columns (should all be 0):';

SELECT
    SUM(CASE WHEN Channel_ID IS NULL THEN 1 ELSE 0 END) AS Null_Channel_ID,
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Null_Customer_ID,
    SUM(CASE WHEN Date_ID IS NULL THEN 1 ELSE 0 END) AS Null_Date_ID,
    SUM(CASE WHEN Store_ID IS NULL THEN 1 ELSE 0 END) AS Null_Store_ID,
    SUM(CASE WHEN Priority_ID IS NULL THEN 1 ELSE 0 END) AS Null_Priority_ID,
    SUM(CASE WHEN Salesperson_ID IS NULL THEN 1 ELSE 0 END) AS Null_Salesperson_ID,
    SUM(CASE WHEN Location_ID IS NULL THEN 1 ELSE 0 END) AS Null_Location_ID,
    SUM(CASE WHEN Payment_Method_ID IS NULL THEN 1 ELSE 0 END) AS Null_Payment_Method_ID,
    SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS Null_Product_ID
FROM pc_sales_dw.dbo.fact_pc_sales;

PRINT 'All values should be 0. If not, some fact records couldn''t match to dimensions.';
PRINT '';

-- =============================================
-- Check 3: Invalid Numeric Values
-- =============================================
PRINT '=== INVALID NUMERIC VALUES CHECK ===';
PRINT 'Checking for negative values in numeric columns (should all be 0):';

SELECT
    COUNT(*) AS Total_Records,
    SUM(CASE WHEN Cost_Price < 0 THEN 1 ELSE 0 END) AS Negative_Cost_Price,
    SUM(CASE WHEN Sale_Price < 0 THEN 1 ELSE 0 END) AS Negative_Sale_Price,
    SUM(CASE WHEN Discount_Amount < 0 THEN 1 ELSE 0 END) AS Negative_Discount_Amount,
    SUM(CASE WHEN Finance_Amount < 0 THEN 1 ELSE 0 END) AS Negative_Finance_Amount,
    SUM(CASE WHEN Cost_of_Repairs < 0 THEN 1 ELSE 0 END) AS Negative_Cost_of_Repairs,
    SUM(CASE WHEN Total_Sales_per_Employee < 0 THEN 1 ELSE 0 END) AS Negative_Total_Sales_per_Employee,
    SUM(CASE WHEN PC_Market_Price < 0 THEN 1 ELSE 0 END) AS Negative_PC_Market_Price,
    SUM(CASE WHEN Credit_Score < 0 THEN 1 ELSE 0 END) AS Negative_Credit_Score
FROM pc_sales_dw.dbo.fact_pc_sales;

PRINT 'All negative counts should be 0. Negative values indicate data quality issues.';
PRINT '';

-- =============================================
-- Check 4: Referential Integrity (Orphaned Records)
-- =============================================
PRINT '=== REFERENTIAL INTEGRITY CHECK ===';
PRINT 'Checking for fact records that don''t have matching dimension records (should all be 0):';

SELECT 'Orphaned Channel_ID' AS Issue, COUNT(*) AS Count
FROM pc_sales_dw.dbo.fact_pc_sales f
LEFT JOIN pc_sales_dw.dbo.dim_channel d ON f.Channel_ID = d.Channel_ID
WHERE d.Channel_ID IS NULL

UNION ALL

SELECT 'Orphaned Customer_ID', COUNT(*)
FROM pc_sales_dw.dbo.fact_pc_sales f
LEFT JOIN pc_sales_dw.dbo.dim_customer d ON f.Customer_ID = d.Customer_ID
WHERE d.Customer_ID IS NULL

UNION ALL

SELECT 'Orphaned Date_ID', COUNT(*)
FROM pc_sales_dw.dbo.fact_pc_sales f
LEFT JOIN pc_sales_dw.dbo.dim_date d ON f.Date_ID = d.Date_ID
WHERE d.Date_ID IS NULL

UNION ALL

SELECT 'Orphaned Store_ID', COUNT(*)
FROM pc_sales_dw.dbo.fact_pc_sales f
LEFT JOIN pc_sales_dw.dbo.dim_store d ON f.Store_ID = d.Store_ID
WHERE d.Store_ID IS NULL

UNION ALL

SELECT 'Orphaned Priority_ID', COUNT(*)
FROM pc_sales_dw.dbo.fact_pc_sales f
LEFT JOIN pc_sales_dw.dbo.dim_priority d ON f.Priority_ID = d.Priority_ID
WHERE d.Priority_ID IS NULL

UNION ALL

SELECT 'Orphaned Salesperson_ID', COUNT(*)
FROM pc_sales_dw.dbo.fact_pc_sales f
LEFT JOIN pc_sales_dw.dbo.dim_salesperson d ON f.Salesperson_ID = d.Salesperson_ID
WHERE d.Salesperson_ID IS NULL

UNION ALL

SELECT 'Orphaned Location_ID', COUNT(*)
FROM pc_sales_dw.dbo.fact_pc_sales f
LEFT JOIN pc_sales_dw.dbo.dim_location d ON f.Location_ID = d.Location_ID
WHERE d.Location_ID IS NULL

UNION ALL

SELECT 'Orphaned Payment_Method_ID', COUNT(*)
FROM pc_sales_dw.dbo.fact_pc_sales f
LEFT JOIN pc_sales_dw.dbo.dim_payment_method d ON f.Payment_Method_ID = d.Payment_Method_ID
WHERE d.Payment_Method_ID IS NULL

UNION ALL

SELECT 'Orphaned Product_ID', COUNT(*)
FROM pc_sales_dw.dbo.fact_pc_sales f
LEFT JOIN pc_sales_dw.dbo.dim_product d ON f.Product_ID = d.Product_ID
WHERE d.Product_ID IS NULL;

PRINT 'All counts should be 0. If not, there are "orphaned" records that couldn''t be matched.';
PRINT 'This could happen if dimension data was filtered out during cleaning.';
PRINT '';
PRINT 'Data quality checks completed!';
PRINT 'Review the results above. If everything looks good (mostly 0s), your warehouse is ready!';