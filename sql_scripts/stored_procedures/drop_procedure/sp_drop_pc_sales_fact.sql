/*DROP the stored procedures for the all the fact*/
CREATE
OR ALTER Procedure Sp_Drop_Fact_Procedure as begin drop Procedure if exists Sp_Pc_Sales_Fact;


end;