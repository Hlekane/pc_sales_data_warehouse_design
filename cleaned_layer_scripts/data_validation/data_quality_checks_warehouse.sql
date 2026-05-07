/* Data validation and quality checks for warehouse */

/* Check row counts for all dimensions */
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

/* Check for nulls in fact table key columns */
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

/* Check for invalid numeric values in fact table */
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

/* Referential integrity check: ensure all fact keys exist in dimensions */
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