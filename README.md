# 🖥️ PC Sales Data Warehouse

![Status](https://img.shields.io/badge/Status-Staging%20Phase-orange)
![SQL Server](https://img.shields.io/badge/SQL%20Server-T--SQL-blue)
![License](https://img.shields.io/badge/License-MIT-green)

A hands-on data engineering project that builds a PC sales data warehouse pipeline focusing on staging, profiling, and the first dimensional load.

---

## 📌 Project Overview

This repository designs and implements a staging-focused data warehouse pipeline for a PC sales dataset.
The primary goal is to land raw CSV data into SQL Server, build staging objects, and create the first dimensional tables and fact table from the staged data.

Key concepts covered:

- Raw data ingestion and staging
- Dimension table creation
- Fact table population
- Stored procedure orchestration
- Data profiling and column grouping

---

## 🎯 What's Included

- `raw_data/pc_sales_dataset_Stg.csv` — source PC sales dataset
- `sql_scripts/create_pc_sales_stg_db.sql` — creates the staging and data warehouse databases
- `sql_scripts/column_grouping_and_data_profiling.sql` — profiling queries and column grouping exploration
- `sql_scripts/data_profiling_with_dims.sql` — dimension build queries and raw profiling output
- `sql_scripts/dim_tables/` — dimension creation scripts for customer, product, date, salesperson, location, channel, payment, priority, and store
- `sql_scripts/fact_table/10.fact_pc_sales_staging.sql` — fact table creation from staging
- `sql_scripts/stored_procedures/` — stored procedures for building dimensions and fact tables
- `sql_scripts/stored_procedures/execute_sp_scripts/` — execution wrappers to run all dimension and fact procedures
- `sql_scripts/stored_procedures/drop_procedure/` — cleanup scripts for stored procedures
- `cleaned_layer_scripts/` — final warehouse layer scripts and validation checks
- `data_architecture/` and `data_planning_docs/` — supporting documentation and architecture planning

---

## 🧩 Architecture Summary

This project currently targets a staging-first data warehouse architecture:

1. Raw CSV data is placed in `raw_data/`
2. SQL Server databases are created: `pc_sales_stg` and `pc_sales_dwh`
3. A staging table is expected to hold the raw dataset as `Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg`
4. Dimension tables are created from the staging dataset
5. The fact table is populated from the same staging source

The current implementation lives in the staging database, with `pc_sales_dwh` reserved for the final warehouse layer.

---

## 📦 Data Model

The dataset supports an eventual star schema with a central sales fact table and multiple dimensions.

### Core dimensions

- `Dim_Customer`
- `Dim_Product`
- `Dim_Date`
- `Dim_Salesperson`
- `Dim_Location`
- `Dim_Channel`
- `Dim_Payment_Method`
- `Dim_Priority`
- `Dim_Store`

### Fact table

- `Pc_Sales_Fact`

The fact table contains sales metrics such as `Cost_Price`, `Sale_Price`, `Discount_Amount`, `Finance_Amount`, `Credit_Score`, `Cost_Of_Repairs`, `Total_Sales_Per_Employee`, and `Pc_Market_Price`.

---

## 🛠️ Database Objects

### Databases created

- `pc_sales_stg`
- `pc_sales_dwh`

### Key SQL objects

- Dimension creation scripts: `sql_scripts/dim_tables/*.sql`
- Fact creation script: `sql_scripts/fact_table/10.fact_pc_sales_staging.sql`
- Stored procedures for dimensions and fact: `sql_scripts/stored_procedures/*.sql`
- Execution wrappers: `sql_scripts/stored_procedures/execute_sp_scripts/*.sql`
- Cleanup procedures: `sql_scripts/stored_procedures/drop_procedure/*.sql`

---

## 🚀 How to Use This Project

### 1. Create the databases

Open `sql_scripts/create_pc_sales_stg_db.sql` and run it in SQL Server Management Studio.

### 2. Load the raw source data

Import `raw_data/pc_sales_dataset_Stg.csv` into a staging table named `Pc_Sales_Stg.dbo.Pc_Sales_Dataset_Stg`.
This can be done with SQL Server Import Wizard, `BULK INSERT`, or `OPENROWSET`.

### 3. Create the dimension tables

Run the stored procedure execution script:

```sql
sql_scripts/stored_procedures/execute_sp_scripts/sp_execute_dim_scripts.sql
```

### 4. Create the fact table

Run the fact execution script:

```sql
sql_scripts/stored_procedures/execute_sp_scripts/sp_execute_fact_script.sql
```

### 5. Review profiling and column grouping

Run:

```sql
sql_scripts/column_grouping_and_data_profiling.sql
sql_scripts/data_profiling_with_dims.sql
```

---

## 📌 Current Status

- Database creation: ✅ Done
- Raw source dataset available: ✅ Done
- Staging data landing: ✅ Planned / ready for import
- Dimension load scripts: ✅ Drafted and executable
- Fact table script: ✅ Drafted and executable
- Stored procedure orchestration: ✅ Available
- End-to-end automation: ⚠️ In progress

---

## 🔍 Notes

- The current implementation uses `DISTINCT` to reduce duplicate values when building dimensions.
- Dimension and fact objects are created in `pc_sales_stg` today; the final warehouse load into `pc_sales_dwh` is a planned next step.
- Quality checks, validation rules, and production-ready automation are future enhancements.

---

## 📁 Folder Guide

- `raw_data/` — source CSV dataset
- `sql_scripts/` — staging SQL definitions, procedures, and ETL scripts
- `cleaned_layer_scripts/` — final cleaned warehouse layer scripts and validation checks
- `data_architecture/` — modelling and architecture design artifacts
- `data_planning_docs/` — project documentation, planning, and analysis

---

## 📚 Recommended Next Steps

1. Add a staging ingestion script or automated `BULK INSERT` logic.
2. Implement validation on required columns, null values, and data types.
3. Move final dimension and fact loads into `pc_sales_dwh`.
4. Add documentation for deployment and scheduling.
5. Create a data dictionary for the source and warehouse schema.

---

## 📜 License

This repository is intended for learning and development and is shared under an open/learning-style license.
