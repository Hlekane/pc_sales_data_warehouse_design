/* Execution script to run the fact table stored procedure */
CREATE OR ALTER PROCEDURE sp_get_fact_table
AS
BEGIN
    EXEC sp_create_pc_sales_fact;
END;
GO