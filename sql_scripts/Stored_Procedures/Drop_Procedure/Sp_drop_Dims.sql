-- Create a stored procedure to DROP the stored procedures for the all the dim tables

USE pc_sales_stg
GO


CREATE PROCEDURE sp_drop_dim_procedures
AS 
BEGIN
DROP PROCEDURE sp_create_dim_customer;

DROP PROCEDURE sp_create_dim_product;

DROP PROCEDURE sp_create_dim_date;

DROP PROCEDURE sp_create_dim_salesperson;

DROP PROCEDURE sp_create_dim_location;

DROP PROCEDURE sp_create_dim_channel;

DROP PROCEDURE sp_create_dim_payment_method;

DROP PROCEDURE sp_create_dim_priority;

DROP PROCEDURE sp_create_dim_store;

END;

EXEC sp_drop_dim_procedures