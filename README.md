# PC_Sales_Stg

![SQL Server](https://img.shields.io/badge/SQL%20Server-T--SQL-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![SSMS](https://img.shields.io/badge/SSMS-Database%20IDE-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Visualisation-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/Status-In%20Progress-orange?style=for-the-badge)
![Level](https://img.shields.io/badge/Level-Learning-brightgreen?style=for-the-badge)

A learning project where I practised dimensional modelling and data warehousing concepts using SQL Server. The goal was to take a flat CSV sales dataset and transform it into a structured star schema that can support basic sales reporting and analysis.

---

## Project Overview

The database models PC sales transactions across multiple stores, channels and salespeople. Raw data is loaded into a staging table first, then cleaned and inserted into a fact table that is surrounded by nine dimension tables.

The focus throughout this project was on understanding **how data flows from a raw source into an analytical structure** rather than just querying existing data.

---

## Star Schema

![Star Schema](star_schema.png)

---

## Project Planning

| Phase | Task | Status |
|-------|------|--------|
| 1 | Design the star schema and identify fact vs dimension tables | ✅ Done |
| 2 | Create the staging database and load the raw CSV data | ✅ Done |
| 3 | Build all dimension tables with surrogate keys | ✅ Done |
| 4 | Build the fact table with foreign key constraints | ✅ Done |
| 5 | Write a stored procedure to automate fact table creation | ✅ Done |
| 6 | Insert measures from staging into the fact table | ✅ Done |
| 7 | Add a LoadDate audit column for basic lineage tracking | ✅ Done |
| 8 | Connect Power BI to the model and build basic visuals | 🔄 In Progress |

---

## Key Concepts Demonstrated

**Star schema design** separates numeric measures in the fact table from the descriptive attributes held in each dimension. This makes the data far easier to query for reporting purposes.

**Surrogate keys** are used on every dimension table. Each dimension gets its own `IDENTITY` primary key that is independent of whatever IDs exist in the source data.

**Foreign key constraints** are declared on the fact table so that every transaction must reference a valid record in each of the nine dimensions. This enforces referential integrity at the database level.

**Stored procedures** wrap the entire fact table lifecycle. The procedure `Sp_Create_PC_Sales_Fact` drops the existing table, recreates it with the correct schema and then reloads the data in a single call.

**Staging layer** ensures the raw source data is kept untouched. Data lands in `PC_sales_dataset_Stg` first before being transformed and loaded downstream.

**Deduplication** is handled during the staging to fact insert using `DISTINCT` to prevent duplicate rows from carrying through to the analytical layer.

**Audit column** — `LoadDate DATETIME DEFAULT GETDATE()` records the timestamp of each row insert so you can trace when data was loaded.

---

## Fact Table Measures

The `PC_Sales_Fact` table captures the following business metrics per transaction.

| Column | Description |
|--------|-------------|
| `Cost_Price` | What the store paid for the unit |
| `Sale_Price` | Price the customer paid |
| `Discount_Amount` | Discount applied at point of sale |
| `Finance_Amount` | Financed portion of the sale |
| `Credit_Score` | Customer credit score at time of sale |
| `Cost_of_Repairs` | Post-sale repair costs attributed to the transaction |
| `Total_Sales_per_Employee` | Salesperson running sales total |
| `PC_Market_Price` | Market value of the product at time of sale |

---

## Dimension Tables

| Dimension | Grain |
|-----------|-------|
| `dim_Customer` | One row per unique customer |
| `dim_Date` | One row per date |
| `dim_Location` | One row per store location |
| `dim_Channel` | One row per sales channel |
| `dim_Payment_Method` | One row per payment type |
| `dim_Store` | One row per store |
| `dim_Product` | One row per product |
| `dim_Priority` | One row per order priority level |
| `dim_Salesperson` | One row per salesperson |

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| SQL Server and T-SQL | Building the database, writing stored procedures and enforcing constraints |
| SSMS | Writing and testing all queries |
| Power BI | Connecting to the star schema and building basic reports |
| GitHub | Version control and project documentation |

---

## What I Learned

Working through this project helped me understand why dimensional modelling exists in the first place. A flat CSV file is difficult to query in any meaningful way. Once the data is split into a fact table and surrounding dimension tables, it becomes straightforward to ask questions like which salesperson had the highest discount rate per channel or how the sale price compares to market price across different product categories.

I also ran into a practical issue when the schema needed to change after the fact table had already been created. That experience led me to wrapping the entire process inside a stored procedure so that rebuilding the table is a single call rather than a manual process.

---

## What is Next

- Correct the data types on `Finance_Amount` and `Cost_of_Repairs` from `NVARCHAR` to `DECIMAL`
- Ensure all foreign key column types match their corresponding dimension primary keys
- Build reporting views on top of the star schema to simplify Power BI queries
- Explore basic indexing to improve query performance as the dataset grows
