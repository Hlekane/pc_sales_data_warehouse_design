/* Create a stored procedure to DROP the stored procedures for the 
 all the dim tables*/
USE pc_sales_stg GO create Procedure Sp_Drop_Dim_Procedures as begin drop Procedure Sp_Create_Dim_Customer;


drop Procedure Sp_Create_Dim_Product;


drop Procedure Sp_Create_Dim_Date;


drop Procedure Sp_Create_Dim_Salesperson;


drop Procedure Sp_Create_Dim_Location;


drop Procedure Sp_Create_Dim_Channel;


drop Procedure Sp_Create_Dim_Payment_Method;


drop Procedure Sp_Create_Dim_Priority;


drop Procedure Sp_Create_Dim_Store;


end;


EXEC sp_drop_dim_procedures