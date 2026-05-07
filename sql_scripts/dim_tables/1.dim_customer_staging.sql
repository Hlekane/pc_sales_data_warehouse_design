
/* Drop dim customer if it exists */
IF OBJECT_ID('pc_sales_stg.dbo.dim_customer', 'U') IS NOT NULL  /* T-SQL logic that allows you to drop the table and recreate it if it exists */
    DROP TABLE pc_sales_stg.dbo.dim_customer;

/* Create a new table and insert a unique ID */
CREATE TABLE pc_sales_stg.dbo.dim_customer (
    Customer_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Customer_Name NVARCHAR(255) NOT NULL,
    Customer_Surname NVARCHAR(255) NOT NULL,
    Customer_Contact_Number NVARCHAR(255) NOT NULL,
    Customer_Email_Address NVARCHAR(255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
);

/* Insert data into the customer dimension from the staging dataset, use DISTINCT to remove duplicates */
INSERT INTO pc_sales_stg.dbo.dim_customer (
    Customer_Name,
    Customer_Surname,
    Customer_Contact_Number,
    Customer_Email_Address
)
SELECT DISTINCT
    Customer_Name,
    Customer_Surname,
    Customer_Contact_Number,
    Customer_Email_Address
FROM pc_sales_stg.dbo.pc_sales_dataset_stg;

/* Select the table to see if the insert was correct */
SELECT *
FROM pc_sales_stg.dbo.dim_customer;