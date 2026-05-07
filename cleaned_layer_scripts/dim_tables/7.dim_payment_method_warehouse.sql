/* Drop dim_payment_method if it exists in warehouse */
IF OBJECT_ID('pc_sales_dw.dbo.dim_payment_method', 'U') IS NOT NULL
    DROP TABLE pc_sales_dw.dbo.dim_payment_method;

/* Create dim_payment_method table in warehouse with cleaned data */
CREATE TABLE pc_sales_dw.dbo.dim_payment_method (
    Payment_Method_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Payment_Method NVARCHAR(255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
);

/* Insert cleaned data into dim_payment_method from staging, with data validation and transformation */
INSERT INTO pc_sales_dw.dbo.dim_payment_method (
    Payment_Method
)
SELECT DISTINCT
    TRIM(ISNULL(Payment_Method, '')) AS Payment_Method
FROM pc_sales_stg.dbo.dim_payment_method
WHERE LEN(TRIM(ISNULL(Payment_Method, ''))) > 0;

/* Validate the loaded data */
SELECT COUNT(*) AS Total_Payment_Methods_Loaded
FROM pc_sales_dw.dbo.dim_payment_method;