/* Drop the initial date dimension without a unique ID */
IF OBJECT_ID('pc_sales_stg.dbo.dim_date', 'U') IS NOT NULL
    DROP TABLE pc_sales_stg.dbo.dim_date;

/* Create a new table and insert a unique ID */
CREATE TABLE pc_sales_stg.dbo.dim_date (
    Date_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Purchase_Date DATETIME2(7) NOT NULL,
    Ship_Date NVARCHAR(50) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
);

/* Insert data into the date dimension from the staging dataset, use DISTINCT to remove duplicates */
INSERT INTO pc_sales_stg.dbo.dim_date (Purchase_Date, Ship_Date)
SELECT DISTINCT
    Purchase_Date,
    Ship_Date
FROM pc_sales_stg.dbo.pc_sales_dataset_stg;

/* Check whether the table was successfully created */
SELECT *
FROM pc_sales_stg.dbo.dim_date;