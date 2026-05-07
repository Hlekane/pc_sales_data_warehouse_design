CREATE OR ALTER PROCEDURE sp_create_dim_date_warehouse
AS
BEGIN
    /* Drop dim_date if it exists in warehouse */
    IF OBJECT_ID('pc_sales_dw.dbo.dim_date', 'U') IS NOT NULL
        DROP TABLE pc_sales_dw.dbo.dim_date;

    /* Create dim_date table in warehouse with cleaned data */
    CREATE TABLE pc_sales_dw.dbo.dim_date (
        Date_ID INT IDENTITY(1, 1) PRIMARY KEY,
        Purchase_Date DATETIME2(7) NOT NULL,
        Ship_Date NVARCHAR(50) NOT NULL,
        LoadDate DATETIME DEFAULT GETDATE()
    );

    /* Insert cleaned data into dim_date from staging, with data validation and transformation */
    INSERT INTO pc_sales_dw.dbo.dim_date (
        Purchase_Date,
        Ship_Date
    )
    SELECT DISTINCT
        Purchase_Date,
        TRIM(ISNULL(Ship_Date, '')) AS Ship_Date
    FROM pc_sales_stg.dbo.dim_date
    WHERE Purchase_Date IS NOT NULL
      AND LEN(TRIM(ISNULL(Ship_Date, ''))) > 0;

    /* Validate the loaded data */
    SELECT COUNT(*) AS Total_Dates_Loaded
    FROM pc_sales_dw.dbo.dim_date;
END;
GO