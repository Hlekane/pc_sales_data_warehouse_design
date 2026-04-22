
-- DROP the stored procedures for the all the fact

CREATE PROCEDURE Sp_Drop_Fact_Procedure
AS
BEGIN
DROP PROCEDURE IF EXISTS Sp_PC_Sales_Fact;

END;