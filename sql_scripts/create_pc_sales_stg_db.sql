USE master;
GO

-- Create Staging Database
IF DB_ID('pc_sales_stg') IS NULL
BEGIN
    CREATE DATABASE pc_sales_stg;
END
GO

-- Create Data Warehouse Database
IF DB_ID('pc_sales_dwh') IS NULL
BEGIN
    CREATE DATABASE pc_sales_dwh;
END
GO