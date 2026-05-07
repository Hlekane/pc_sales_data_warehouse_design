/* Drop dim_location if it exists in warehouse */
IF OBJECT_ID('pc_sales_dw.dbo.dim_location', 'U') IS NOT NULL
    DROP TABLE pc_sales_dw.dbo.dim_location;

/* Create dim_location table in warehouse with cleaned data */
CREATE TABLE pc_sales_dw.dbo.dim_location (
    Location_ID INT IDENTITY(1, 1) PRIMARY KEY,
    Continent NVARCHAR(255) NOT NULL,
    Country_Or_State NVARCHAR(255) NOT NULL,
    Province_Or_City NVARCHAR(255) NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
);

/* Insert cleaned data into dim_location from staging, with data validation and transformation */
INSERT INTO pc_sales_dw.dbo.dim_location (
    Continent,
    Country_Or_State,
    Province_Or_City
)
SELECT DISTINCT
    TRIM(ISNULL(Continent, '')) AS Continent,
    TRIM(ISNULL(Country_Or_State, '')) AS Country_Or_State,
    TRIM(ISNULL(Province_Or_City, '')) AS Province_Or_City
FROM pc_sales_stg.dbo.dim_location
WHERE LEN(TRIM(ISNULL(Continent, ''))) > 0
  AND LEN(TRIM(ISNULL(Country_Or_State, ''))) > 0
  AND LEN(TRIM(ISNULL(Province_Or_City, ''))) > 0;

/* Validate the loaded data */
SELECT COUNT(*) AS Total_Locations_Loaded
FROM pc_sales_dw.dbo.dim_location;