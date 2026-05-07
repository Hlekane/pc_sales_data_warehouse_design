CREATE OR ALTER PROCEDURE sp_create_dim_channel_warehouse
AS
BEGIN
    /* Drop dim_channel if it exists in warehouse */
    IF OBJECT_ID('pc_sales_dw.dbo.dim_channel', 'U') IS NOT NULL
        DROP TABLE pc_sales_dw.dbo.dim_channel;

    /* Create dim_channel table in warehouse with cleaned data */
    CREATE TABLE pc_sales_dw.dbo.dim_channel (
        Channel_ID INT IDENTITY(1, 1) PRIMARY KEY,
        Channel NVARCHAR(255) NOT NULL,
        LoadDate DATETIME DEFAULT GETDATE()
    );

    /* Insert cleaned data into dim_channel from staging, with data validation and transformation */
    INSERT INTO pc_sales_dw.dbo.dim_channel (
        Channel
    )
    SELECT DISTINCT
        TRIM(ISNULL(Channel, '')) AS Channel
    FROM pc_sales_stg.dbo.dim_channel
    WHERE LEN(TRIM(ISNULL(Channel, ''))) > 0;

    /* Validate the loaded data */
    SELECT COUNT(*) AS Total_Channels_Loaded
    FROM pc_sales_dw.dbo.dim_channel;
END;
GO