/* =============================================
 Script: Create Salesperson Dimension Table (Staging)
 Purpose: This script creates the salesperson dimension table
 in the staging database by loading data from the raw dataset.
 ============================================= */
/* Create a new table and insert a unique ID */
CREATE TABLE
  pc_sales_stg.dbo.dim_salesperson (
    Salesperson_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Sales_Person_Name NVARCHAR(255) NOT NULL,
    Sales_Person_Department NVARCHAR(255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
  );


/* Insert data into the salesperson dimension from the staging dataset, use DISTINCT to remove duplicates */
INSERT INTO
  pc_sales_stg.dbo.dim_salesperson (Sales_Person_Name, Sales_Person_Department)
SELECT
  DISTINCT Sales_Person_Name,
  Sales_Person_Department
FROM
  pc_sales_stg.dbo.pc_sales_dataset_stg;


-- Check whether the table was successfully created (commented out for production)
-- SELECT * FROM pc_sales_stg.dbo.dim_salesperson;