/* Drop the stored procedure for the fact table */
CREATE OR ALTER PROCEDURE sp_drop_fact_procedure
AS
BEGIN
    DROP PROCEDURE IF EXISTS sp_create_pc_sales_fact;
END;
GO