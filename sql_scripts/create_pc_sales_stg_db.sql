USE master;


GO
/*Create Staging Database*/
IF DB_ID ('pc_sales_stg') IS NULL begin create Database pc_sales_stg;


end;
go


/* Create Data Warehouse Database*/
IF DB_ID ('pc_sales_dwh') IS NULL begin create Database Pc_Sales_Dwh;


end;
go