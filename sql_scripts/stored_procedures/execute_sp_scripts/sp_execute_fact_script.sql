/* Execution scripts to call on the saved stored procedures statement for the 
 fact table*/
USE pc_sales_stg GO CREATE
OR ALTER Procedure Sp_Get_Fact_Table as begin Exec Sp_Create_Pc_Sales_Fact
end;