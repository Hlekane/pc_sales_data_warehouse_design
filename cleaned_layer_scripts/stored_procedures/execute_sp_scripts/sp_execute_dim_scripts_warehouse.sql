/* Execute warehouse dimension creation stored procedures */

/* Create dim_customer in warehouse */
EXEC sp_create_dim_customer_warehouse;

/* Create dim_product in warehouse */
EXEC sp_create_dim_product_warehouse;

/* Create dim_date in warehouse */
EXEC sp_create_dim_date_warehouse;

/* Create dim_salesperson in warehouse */
EXEC sp_create_dim_salesperson_warehouse;

/* Create dim_location in warehouse */
EXEC sp_create_dim_location_warehouse;

/* Create dim_channel in warehouse */
EXEC sp_create_dim_channel_warehouse;

/* Create dim_payment_method in warehouse */
EXEC sp_create_dim_payment_method_warehouse;

/* Create dim_priority in warehouse */
EXEC sp_create_dim_priority_warehouse;

/* Create dim_store in warehouse */
EXEC sp_create_dim_store_warehouse;