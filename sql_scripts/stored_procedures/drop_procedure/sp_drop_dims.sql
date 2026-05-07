/* Create a stored procedure to drop the dimension stored procedures */
CREATE OR ALTER PROCEDURE sp_drop_dim_procedures
AS
BEGIN
    DROP PROCEDURE IF EXISTS sp_create_dim_customer;
    DROP PROCEDURE IF EXISTS sp_create_dim_product;
    DROP PROCEDURE IF EXISTS sp_create_dim_date;
    DROP PROCEDURE IF EXISTS sp_create_dim_salesperson;
    DROP PROCEDURE IF EXISTS sp_create_dim_location;
    DROP PROCEDURE IF EXISTS sp_create_dim_channel;
    DROP PROCEDURE IF EXISTS sp_create_dim_payment_method;
    DROP PROCEDURE IF EXISTS sp_create_dim_priority;
    DROP PROCEDURE IF EXISTS sp_create_dim_store;
END;
GO

EXEC sp_drop_dim_procedures;