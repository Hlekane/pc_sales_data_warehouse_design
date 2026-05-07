CREATE OR ALTER PROCEDURE sp_create_dim_location
AS
BEGIN
    /* Drop dim_location if it exists */
    IF OBJECT_ID('pc_sales_stg.dbo.dim_location', 'U') IS NOT NULL
    BEGIN
        DROP TABLE pc_sales_stg.dbo.dim_location;
    END;

    /* Create a new table and insert a unique ID */
    CREATE TABLE pc_sales_stg.dbo.dim_location (
        Location_ID INT IDENTITY(1, 1) PRIMARY KEY,
        Continent NVARCHAR(255) NOT NULL,
        Country_Or_State NVARCHAR(255) NOT NULL,
        Province_Or_City NVARCHAR(255) NOT NULL,
        LoadDate DATETIME DEFAULT GETDATE()
    );

    /* Insert data into the location dimension from the staging dataset, use DISTINCT to remove duplicates */
    INSERT INTO pc_sales_stg.dbo.dim_location (Continent, Country_Or_State, Province_Or_City)
    SELECT DISTINCT
        Continent,
        Country_Or_State,
        Province_Or_City
    FROM pc_sales_stg.dbo.pc_sales_dataset_stg;

    /* Check whether the table was successfully created */
    SELECT *
    FROM pc_sales_stg.dbo.dim_location;
END;
GO