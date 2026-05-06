/* Create a stored procedure to DROP the stored procedures for the 
 all the dim tables*/
 CREATE
Procedure Sp_Drop_Dim_Procedures as begin drop Procedure sp_create_dim_customer;


drop Procedure sp_create_dim_product;


drop Procedure sp_Create_dim_date;


drop Procedure sp_create_dim_salesperson;


drop Procedure sp_create_dim_location;


drop Procedure sp_create_dim_channel;


drop Procedure sp_create_dim_payment_method;


drop Procedure sp_create_dim_priority;


drop Procedure sp_create_dim_store;


end;
go

EXEC sp_drop_dim_procedures