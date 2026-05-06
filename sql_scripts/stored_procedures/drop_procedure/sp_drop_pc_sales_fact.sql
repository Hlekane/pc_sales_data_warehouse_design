/*DROP the stored procedures for the all the fact*/
CREATE
OR ALTER Procedure Sp_Drop_Fact_Procedure as begin drop Procedure if exists sp_create_pc_sales_fact;


end;