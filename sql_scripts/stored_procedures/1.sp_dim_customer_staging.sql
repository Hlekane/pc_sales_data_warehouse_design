/* =============================================
Stored Procedure: Create Customer Dimension (Staging)
Purpose: This procedure creates the customer dimension table
          in the staging database by loading data from the raw dataset.
============================================= */
CREATE
OR ALTER PROCEDURE sp_create_dim_customer AS BEGIN /* Print a message to show the procedure started */
PRINT 'Starting customer dimension creation...';


/* Drop dim_customer if it exists */
IF OBJECT_ID('pc_sales_stg.dbo.dim_customer', 'U') IS NOT NULL BEGIN
DROP TABLE
  pc_sales_stg.dbo.dim_customer;


PRINT 'Dropped existing dim_customer table.';


END;


/* Create a new table and insert a unique ID */
CREATE TABLE
  pc_sales_stg.dbo.dim_customer (
    Customer_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Customer_Name NVARCHAR(255) NOT NULL,
    Customer_Surname NVARCHAR(255) NOT NULL,
    Customer_Contact_Number NVARCHAR(255) NOT NULL,
    Customer_Email_Address NVARCHAR(255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
  );


PRINT 'Created new dim_customer table.';


/* Insert data into the customer dimension from the staging dataset, use DISTINCT to remove duplicates */
INSERT INTO
  pc_sales_stg.dbo.dim_customer (
    Customer_Name,
    Customer_Surname,
    Customer_Contact_Number,
    Customer_Email_Address
  )
SELECT
  DISTINCT Customer_Name,
  Customer_Surname,
  Customer_Contact_Number,
  Customer_Email_Address
FROM
  pc_sales_stg.dbo.pc_sales_dataset_stg;


PRINT 'Inserted customer data.';


/* Select the table to verify results (commented out for production) */
/* SELECT * FROM pc_sales_stg.dbo.dim_customer; */
PRINT 'Customer dimension table creation completed successfully!';


END;


GO