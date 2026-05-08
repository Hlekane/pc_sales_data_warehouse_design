/* =============================================
 Script: Create Date Dimension Table (Staging)
 Purpose: This script creates the date dimension table
 in the staging database by loading data from the raw dataset.
 ============================================= */
/* Create a new table and insert a unique ID */
CREATE TABLE
  pc_sales_stg.dbo.dim_date (
    Date_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Purchase_Date DATETIME2(7) NOT NULL,
    Ship_Date NVARCHAR(50) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
  );


/* Insert data into the date dimension from the staging dataset, use DISTINCT to remove duplicates */
INSERT INTO
  pc_sales_stg.dbo.dim_date (Purchase_Date, Ship_Date)
SELECT
  DISTINCT Purchase_Date,
  Ship_Date
FROM
  pc_sales_stg.dbo.pc_sales_dataset_stg;


-- Check whether the table was successfully created (commented out for production)
-- SELECT * FROM pc_sales_stg.dbo.dim_date;