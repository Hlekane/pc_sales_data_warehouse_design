CREATE OR ALTER PROCEDURE sp_create_dim_priority
AS
BEGIN
    /* Drop dim_priority if it exists */
    IF OBJECT_ID('pc_sales_stg.dbo.dim_priority', 'U') IS NOT NULL
    BEGIN
        DROP TABLE pc_sales_stg.dbo.dim_priority;
    END;

    /* Create a new table and insert a unique ID */
    CREATE TABLE pc_sales_stg.dbo.dim_priority (
        Priority_ID INT IDENTITY(1, 1) PRIMARY KEY,
        Priority NVARCHAR(255) NOT NULL,
        LoadDate DATETIME DEFAULT GETDATE()
    );

    /* Insert data into the priority dimension from the staging dataset, use DISTINCT to remove duplicates */
    INSERT INTO pc_sales_stg.dbo.dim_priority (Priority)
    SELECT DISTINCT
        Priority
    FROM pc_sales_stg.dbo.pc_sales_dataset_stg;

    /* Check whether the table was successfully created */
    SELECT *
    FROM pc_sales_stg.dbo.dim_priority;
END;
GO