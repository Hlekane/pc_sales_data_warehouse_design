/* Drop dim_priority if it exists in warehouse */
IF OBJECT_ID('pc_sales_dw.dbo.dim_priority', 'U') IS NOT NULL
    DROP TABLE pc_sales_dw.dbo.dim_priority;

/* Create dim_priority table in warehouse with cleaned data */
CREATE TABLE pc_sales_dw.dbo.dim_priority (
    Priority_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Priority NVARCHAR(255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
);

/* Insert cleaned data into dim_priority from staging, with data validation and transformation */
INSERT INTO pc_sales_dw.dbo.dim_priority (
    Priority
)
SELECT DISTINCT
    TRIM(ISNULL(Priority, '')) AS Priority
FROM pc_sales_stg.dbo.dim_priority
WHERE LEN(TRIM(ISNULL(Priority, ''))) > 0;

/* Validate the loaded data */
SELECT COUNT(*) AS Total_Priorities_Loaded
FROM pc_sales_dw.dbo.dim_priority;