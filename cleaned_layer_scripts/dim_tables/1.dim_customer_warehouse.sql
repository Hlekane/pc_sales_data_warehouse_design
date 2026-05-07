/* Drop dim_customer if it exists in warehouse */
IF OBJECT_ID('pc_sales_dw.dbo.dim_customer', 'U') IS NOT NULL
    DROP TABLE pc_sales_dw.dbo.dim_customer;

/* Create dim_customer table in warehouse with cleaned data */
CREATE TABLE pc_sales_dw.dbo.dim_customer (
    Customer_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Customer_Name NVARCHAR(255) NOT NULL,
    Customer_Surname NVARCHAR(255) NOT NULL,
    Customer_Contact_Number NVARCHAR(255) NOT NULL,
    Customer_Email_Address NVARCHAR(255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
);

/* Insert cleaned data into dim_customer from staging, with data validation and transformation */
INSERT INTO pc_sales_dw.dbo.dim_customer (
    Customer_Name,
    Customer_Surname,
    Customer_Contact_Number,
    Customer_Email_Address
)
SELECT DISTINCT
    TRIM(ISNULL(Customer_Name, '')) AS Customer_Name,
    TRIM(ISNULL(Customer_Surname, '')) AS Customer_Surname,
    TRIM(ISNULL(Customer_Contact_Number, '')) AS Customer_Contact_Number,
    TRIM(ISNULL(Customer_Email_Address, '')) AS Customer_Email_Address
FROM pc_sales_stg.dbo.dim_customer
WHERE LEN(TRIM(ISNULL(Customer_Name, ''))) > 0
  AND LEN(TRIM(ISNULL(Customer_Surname, ''))) > 0
  AND LEN(TRIM(ISNULL(Customer_Contact_Number, ''))) > 0
  AND LEN(TRIM(ISNULL(Customer_Email_Address, ''))) > 0;

/* Validate the loaded data */
SELECT COUNT(*) AS Total_Customers_Loaded
FROM pc_sales_dw.dbo.dim_customer;