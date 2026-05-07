CREATE OR ALTER PROCEDURE sp_create_dim_store_warehouse
AS
BEGIN
    /* Drop dim_store if it exists in warehouse */
    IF OBJECT_ID('pc_sales_dw.dbo.dim_store', 'U') IS NOT NULL
        DROP TABLE pc_sales_dw.dbo.dim_store;

    /* Create dim_store table in warehouse with cleaned data */
    CREATE TABLE pc_sales_dw.dbo.dim_store (
        Store_ID INT IDENTITY(1, 1) PRIMARY KEY,
        Shop_Name NVARCHAR(255) NOT NULL,
        Shop_Age NVARCHAR(255) NOT NULL,
        LoadDate DATETIME DEFAULT GETDATE()
    );

    /* Insert cleaned data into dim_store from staging, with data validation and transformation */
    INSERT INTO pc_sales_dw.dbo.dim_store (
        Shop_Name,
        Shop_Age
    )
    SELECT DISTINCT
        TRIM(ISNULL(Shop_Name, '')) AS Shop_Name,
        TRIM(ISNULL(Shop_Age, '')) AS Shop_Age
    FROM pc_sales_stg.dbo.dim_store
    WHERE LEN(TRIM(ISNULL(Shop_Name, ''))) > 0
      AND LEN(TRIM(ISNULL(Shop_Age, ''))) > 0;

    /* Validate the loaded data */
    SELECT COUNT(*) AS Total_Stores_Loaded
    FROM pc_sales_dw.dbo.dim_store;
END;
GO