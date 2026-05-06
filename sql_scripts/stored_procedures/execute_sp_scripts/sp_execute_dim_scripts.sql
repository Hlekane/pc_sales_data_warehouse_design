/* Execution scripts to call on the saved stored procedures statements*/
 CREATE
Procedure Sp_Get_Dims as begin Exec sp_create_dim_customer;


Exec sp_create_dim_product;


Exec sp_create_dim_date;


Exec sp_create_dim_salesperson;


Exec sp_create_dim_location;


Exec sp_create_dim_channel;


Exec sp_create_dim_payment_method;


Exec sp_create_dim_priority;


Exec sp_create_dim_store;


end;
Go