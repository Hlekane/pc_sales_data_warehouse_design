/* Drop dim_salesperson if it exists in warehouse */
IF OBJECT_ID('pc_sales_dw.dbo.dim_salesperson', 'U') IS NOT NULL
    DROP TABLE pc_sales_dw.dbo.dim_salesperson;

/* Create dim_salesperson table in warehouse with cleaned data */
CREATE TABLE pc_sales_dw.dbo.dim_salesperson (
    Salesperson_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Sales_Person_Name NVARCHAR(255) NOT NULL,
    Sales_Person_Department NVARCHAR(255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
);

/* Insert cleaned data into dim_salesperson from staging, with data validation and transformation */
INSERT INTO pc_sales_dw.dbo.dim_salesperson (
    Sales_Person_Name,
    Sales_Person_Department
)
SELECT DISTINCT
    TRIM(ISNULL(Sales_Person_Name, '')) AS Sales_Person_Name,
    TRIM(ISNULL(Sales_Person_Department, '')) AS Sales_Person_Department
FROM pc_sales_stg.dbo.dim_salesperson
WHERE LEN(TRIM(ISNULL(Sales_Person_Name, ''))) > 0
  AND LEN(TRIM(ISNULL(Sales_Person_Department, ''))) > 0;

/* Validate the loaded data */
SELECT COUNT(*) AS Total_Salespersons_Loaded
FROM pc_sales_dw.dbo.dim_salesperson;