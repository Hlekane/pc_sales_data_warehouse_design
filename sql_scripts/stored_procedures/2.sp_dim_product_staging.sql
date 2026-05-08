/* =============================================
 Stored Procedure: Create Product Dimension (Staging)
 Purpose: This procedure creates the product dimension table
 in the staging database by loading data from the raw dataset.
 ============================================= */
CREATE
OR ALTER PROCEDURE sp_create_dim_product AS BEGIN
/* Print a message to show the procedure started */
PRINT 'Starting product dimension creation...';


/* Drop dim_product if it exists */
IF OBJECT_ID('pc_sales_stg.dbo.dim_product', 'U') IS NOT NULL BEGIN
DROP TABLE
  pc_sales_stg.dbo.dim_product;


PRINT 'Dropped existing dim_product table.';


END;


/* Create a new table and insert a unique ID */
CREATE TABLE
  pc_sales_stg.dbo.dim_product (
    Product_ID INT IDENTITY(1, 1) PRIMARY KEY,
    PC_Make NVARCHAR(255) NOT NULL,
    PC_Model NVARCHAR(255) NOT NULL,
    Storage_Type NVARCHAR(255) NOT NULL,
    Storage_Capacity NVARCHAR(255) NOT NULL,
    RAM NVARCHAR(255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
  );


PRINT 'Created new dim_product table.';


/* Insert data into the product dimension from the staging dataset, use DISTINCT to remove duplicates */
INSERT INTO
  pc_sales_stg.dbo.dim_product (
    PC_Make,
    PC_Model,
    Storage_Type,
    Storage_Capacity,
    RAM
  )
SELECT
  DISTINCT PC_Make,
  PC_Model,
  Storage_Type,
  Storage_Capacity,
  RAM
FROM
  pc_sales_stg.dbo.pc_sales_dataset_stg;


PRINT 'Inserted product data.';


PRINT 'Product dimension table creation completed successfully!';


END;


GO