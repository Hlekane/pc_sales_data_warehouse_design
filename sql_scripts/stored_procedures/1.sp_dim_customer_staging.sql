CREATE OR ALTER PROCEDURE sp_create_dim_customer
AS
BEGIN
    /* Drop dim_customer if it exists */
    IF OBJECT_ID('pc_sales_stg.dbo.dim_customer', 'U') IS NOT NULL
    BEGIN
        DROP TABLE pc_sales_stg.dbo.dim_customer;
    END;

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

    /* Select the table to verify results */
    SELECT *
    FROM pc_sales_stg.dbo.dim_customer;
END;
GO

EXEC sp_create_dim_customer;