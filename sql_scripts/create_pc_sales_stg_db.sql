USE master;


GO
/*Create Staging Database*/
IF DB_ID ('pc_sales_stg') IS NULL begin create Database Pc_Sales_Stg;


end Go;


/* Create Data Warehouse Database*/
IF DB_ID ('pc_sales_dwh') IS NULL begin create Database Pc_Sales_Dwh;


end Go;