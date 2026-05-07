CREATE PROCEDURE sp_create_pc_sales_fact
AS
BEGIN
/*Create fact table*/
IF OBJECT_ID('pc_sales_stg.dbo.pc_sales_fact', 'U') IS NOT NULL
    DROP TABLE pc_sales_stg.dbo.pc_sales_fact;

CREATE TABLE pc_sales_stg.dbo.pc_sales_fact (
    PC_Sales_ID INT IDENTITY (1,1) PRIMARY KEY,

    Channel_ID INT NOT NULL,
    Customer_ID INT NOT NULL,
    Date_ID INT NOT NULL,
    Store_ID INT NOT NULL,
    Priority_ID INT NOT NULL,
    Salesperson_ID INT NOT NULL,
    Location_ID INT NOT NULL,
    Payment_Method_ID INT NOT NULL,
    Product_ID INT NOT NULL,

    Cost_Price DECIMAL(10,2) NOT NULL,
    Sale_Price DECIMAL(10,2) NOT NULL,
    Discount_Amount DECIMAL(10,2) NOT NULL,
    Finance_Amount DECIMAL(10,2) NOT NULL,
    Cost_of_Repairs DECIMAL(10,2) NOT NULL,
    Total_Sales_per_Employee DECIMAL(10,2) NOT NULL,
    PC_Market_Price DECIMAL(10,2) NOT NULL,
    Credit_Score INT NOT NULL,
    LoadDate DATETIME DEFAULT GETDATE()
);

/*Insert values into table*/
INSERT INTO pc_sales_stg.dbo.pc_sales_fact (

    Channel_ID,
    Customer_ID,
    Date_ID,
    Store_ID,
    Priority_ID,
    Salesperson_ID,
    Location_ID,
    Payment_Method_ID,
    Product_ID,

    Cost_Price,
    Sale_Price,
    Discount_Amount,
    Finance_Amount,
    Cost_of_Repairs,
    Total_Sales_per_Employee,
    PC_Market_Price,
    Credit_Score
)

SELECT
    ch.Channel_ID,
    c.Customer_ID,
    d.Date_ID,
    s.Store_ID,
    pr.Priority_ID,
    sp.Salesperson_ID,
    l.Location_ID,
    pm.Payment_Method_ID,
    p.Product_ID,

    std.Cost_Price,
    std.Sale_Price,
    std.Discount_Amount,
    std.Finance_Amount,
    std.Cost_of_Repairs,
    std.Total_Sales_per_Employee,
    std.PC_Market_Price,
    std.Credit_Score

FROM pc_sales_stg.dbo.pc_sales_dataset_stg AS std

/*Join on demensions*/

INNER JOIN pc_sales_stg.dbo.dim_channel ch
    ON std.Channel = ch.Channel

INNER JOIN pc_sales_stg.dbo.dim_customer c
    ON std.Customer_Name = c.Customer_Name
    AND std.Customer_Surname = c.Customer_Surname
    AND std.Customer_Contact_Number = c.Customer_Contact_Number
    AND std.Customer_Email_Address = c.Customer_Email_Address

INNER JOIN pc_sales_stg.dbo.dim_date d
    ON std.Purchase_Date = d.Purchase_Date
    AND std.Ship_Date = d.Ship_Date

INNER JOIN pc_sales_stg.dbo.dim_store s
    ON std.Shop_Name = s.Shop_Name
    AND std.Shop_Age = s.Shop_Age

INNER JOIN pc_sales_stg.dbo.dim_priority pr
    ON std.Priority = pr.Priority

INNER JOIN pc_sales_stg.dbo.dim_salesperson sp
    ON std.Sales_Person_Name = sp.Sales_Person_Name
    AND std.Sales_Person_Department = sp.Sales_Person_Department

INNER JOIN pc_sales_stg.dbo.dim_location l
    ON std.Continent = l.Continent
    AND std.Country_Or_State = l.Country_Or_State
    AND std.Province_Or_City = l.Province_Or_City

INNER JOIN pc_sales_stg.dbo.dim_payment_method pm
    ON std.Payment_Method = pm.Payment_Method

INNER JOIN pc_sales_stg.dbo.dim_product p
    ON std.PC_Model = p.PC_Model
    AND std.PC_Make = p.PC_Make
    AND std.Storage_Capacity = p.Storage_Capacity
    AND std.Storage_Type = p.Storage_Type
    AND std.RAM = p.RAM;


/*Check the data*/
SELECT * 
FROM pc_sales_stg.dbo.pc_sales_fact;
END;
GO