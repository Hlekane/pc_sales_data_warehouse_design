/* Execution script to run the fact table stored procedure */
CREATE OR ALTER PROCEDURE sp_get_pc_sales_fact
AS
BEGIN
    EXEC sp_create_pc_sales_fact;
END;
GO