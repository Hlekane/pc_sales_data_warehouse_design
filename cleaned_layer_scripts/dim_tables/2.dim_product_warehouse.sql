/* Drop dim_product if it exists in warehouse */
IF OBJECT_ID('pc_sales_dw.dbo.dim_product', 'U') IS NOT NULL
    DROP TABLE pc_sales_dw.dbo.dim_product;

/* Create dim_product table in warehouse with cleaned data */
CREATE TABLE pc_sales_dw.dbo.dim_product (
    Product_ID INT IDENTITY(1, 1) PRIMARY KEY,
    PC_Make NVARCHAR(255) NOT NULL,
    PC_Model NVARCHAR(255) NOT NULL,
    Storage_Type NVARCHAR(255) NOT NULL,
    Storage_Capacity NVARCHAR(255) NOT NULL,
    RAM NVARCHAR(255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
);

/* Insert cleaned data into dim_product from staging, with data validation and transformation */
INSERT INTO pc_sales_dw.dbo.dim_product (
    PC_Make,
    PC_Model,
    Storage_Type,
    Storage_Capacity,
    RAM
)
SELECT DISTINCT
    TRIM(ISNULL(PC_Make, '')) AS PC_Make,
    TRIM(ISNULL(PC_Model, '')) AS PC_Model,
    TRIM(ISNULL(Storage_Type, '')) AS Storage_Type,
    TRIM(ISNULL(Storage_Capacity, '')) AS Storage_Capacity,
    TRIM(ISNULL(RAM, '')) AS RAM
FROM pc_sales_stg.dbo.dim_product
WHERE LEN(TRIM(ISNULL(PC_Make, ''))) > 0
  AND LEN(TRIM(ISNULL(PC_Model, ''))) > 0
  AND LEN(TRIM(ISNULL(Storage_Type, ''))) > 0
  AND LEN(TRIM(ISNULL(Storage_Capacity, ''))) > 0
  AND LEN(TRIM(ISNULL(RAM, ''))) > 0;

/* Validate the loaded data */
SELECT COUNT(*) AS Total_Products_Loaded
FROM pc_sales_dw.dbo.dim_product;