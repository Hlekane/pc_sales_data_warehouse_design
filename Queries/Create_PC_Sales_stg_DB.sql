-- Create staging database

IF DB_ID('PC_Sales_Stg') IS NOT NULL
BEGIN
    CREATE DATABASE PC_Sales_DW;
    
END
GO

-- Create dataware house database
IF DB_ID('PC_Sal_Dwh') IS NOT NULL
BEGIN
    CREATE DATABASE PC_Sales_Dwh;
    
END
GO