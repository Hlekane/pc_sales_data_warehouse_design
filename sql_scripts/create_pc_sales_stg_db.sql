/* =============================================
Script: Create Staging and Warehouse Databases
Purpose: This script creates the staging and warehouse databases.
============================================= */
USE master;


GO /* Create Staging Database */
IF DB_ID('pc_sales_stg') IS NULL BEGIN CREATE DATABASE pc_sales_stg;


END;


GO /* Create Data Warehouse Database */
IF DB_ID('pc_sales_dw') IS NULL BEGIN CREATE DATABASE pc_sales_dw;


END;


GO