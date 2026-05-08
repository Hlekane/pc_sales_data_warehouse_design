/* =============================================
Script: Create Channel Dimension Table (Staging)
Purpose: This script creates the channel dimension table
          in the staging database by loading data from the raw dataset.
============================================= */
/* Create a new table and insert a unique ID */
CREATE TABLE
  pc_sales_stg.dbo.dim_channel (
    Channel_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Channel NVARCHAR(255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
  );


/* Insert data into the channel dimension from the staging dataset, use DISTINCT to remove duplicates */
INSERT INTO
  pc_sales_stg.dbo.dim_channel (Channel)
SELECT
  DISTINCT Channel
FROM
  pc_sales_stg.dbo.pc_sales_dataset_stg;


-- Check whether the table was successfully created (commented out for production)
-- SELECT * FROM pc_sales_stg.dbo.dim_channel;