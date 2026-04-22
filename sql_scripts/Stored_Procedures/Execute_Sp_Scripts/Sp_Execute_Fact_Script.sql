

-- Execution scripts to call on the saved stored procedures statement for the dact table
USE pc_sales_stg
GO

CREATE PROCEDURE sp_get_fact_table
AS
BEGIN

EXEC sp_create_pc_sales_fact

END;