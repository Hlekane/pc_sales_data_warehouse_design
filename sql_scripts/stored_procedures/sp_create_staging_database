USE master;
GO

/* Create a stored procedure to create staging and warehouse databases */
CREATE OR ALTER PROCEDURE sp_create_staging_database
AS
BEGIN
    IF DB_ID('pc_sales_stg') IS NULL
    BEGIN
        CREATE DATABASE pc_sales_stg;
    END;

    IF DB_ID('pc_sales_dwh') IS NULL
    BEGIN
        CREATE DATABASE pc_sales_dwh;
    END;
END;
GO
