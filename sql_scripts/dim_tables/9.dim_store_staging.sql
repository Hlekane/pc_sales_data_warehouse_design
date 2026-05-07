/* Drop the initial store dimension without a unique ID */
IF OBJECT_ID('pc_sales_stg.dbo.dim_store', 'U') IS NOT NULL
    DROP TABLE pc_sales_stg.dbo.dim_store;

/* Create a new table and insert a unique ID */
CREATE TABLE pc_sales_stg.dbo.dim_store (
    Store_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Shop_Name NVARCHAR(255) NOT NULL,
    Shop_Age NVARCHAR(255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
);

/* Insert data into the store dimension from the staging dataset, use DISTINCT to remove duplicates */
INSERT INTO pc_sales_stg.dbo.dim_store (Shop_Name, Shop_Age)
SELECT DISTINCT
    Shop_Name,
    Shop_Age
FROM pc_sales_stg.dbo.pc_sales_dataset_stg;

/* Check whether the table was successfully created */
SELECT *
FROM pc_sales_stg.dbo.dim_store;