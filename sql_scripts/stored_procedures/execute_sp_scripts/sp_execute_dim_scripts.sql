/* =============================================
Stored Procedure: Execute Dimension Scripts (Staging)
Purpose: This procedure executes all dimension creation procedures.
============================================= */
CREATE
OR ALTER PROCEDURE sp_get_dims AS BEGIN /* Execute dimension stored procedures */
EXEC sp_create_dim_customer;


EXEC sp_create_dim_product;


EXEC sp_create_dim_date;


EXEC sp_create_dim_salesperson;


EXEC sp_create_dim_location;


EXEC sp_create_dim_channel;


EXEC sp_create_dim_payment_method;


EXEC sp_create_dim_priority;


EXEC sp_create_dim_store;


END;


GO