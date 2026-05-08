/* =============================================
 Script: Create Location Dimension Table (Staging)
 Purpose: This script creates the location dimension table
 in the staging database by loading data from the raw dataset.
 ============================================= */
/* Create a new table and insert a unique ID */
CREATE TABLE
  pc_sales_stg.dbo.dim_location (
    Location_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Continent NVARCHAR(255) NOT NULL,
    Country_Or_State NVARCHAR(255) NOT NULL,
    Province_Or_City NVARCHAR(255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
  );


/* Insert data into the location dimension from the staging dataset, use DISTINCT to remove duplicates */
INSERT INTO
  pc_sales_stg.dbo.dim_location (Continent, Country_Or_State, Province_Or_City)
SELECT
  DISTINCT Continent,
  Country_Or_State,
  Province_Or_City
FROM
  pc_sales_stg.dbo.pc_sales_dataset_stg;


-- Check whether the table was successfully created (commented out for production)
-- SELECT * FROM pc_sales_stg.dbo.dim_location;