/* Execution scripts to call on the saved stored procedures statement for the 
 fact table*/
 CREATE
Procedure Sp_Get_Fact_Table as begin Exec sp_create_pc_sales_fact
end;
Go