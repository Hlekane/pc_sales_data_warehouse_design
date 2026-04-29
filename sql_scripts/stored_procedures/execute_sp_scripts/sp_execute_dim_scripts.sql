/* Execution scripts to call on the saved stored procedures statements*/
USE pc_sales_stg GO CREATE
OR ALTER Procedure Sp_Get_Dims as begin Exec Sp_Create_Dim_Customer;


Exec Sp_Create_Dim_Product;


Exec Sp_Create_Dim_Date;


Exec Sp_Create_Dim_Salesperson;


Exec Sp_Create_Dim_Location;


Exec Sp_Create_Dim_Channel;


Exec Sp_Create_Dim_Payment_Method;


Exec Sp_Create_Dim_Priority;


Exec Sp_Create_Dim_Store;


end;