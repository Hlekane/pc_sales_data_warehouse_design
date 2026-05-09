# 🖥️ PC Sales Data Warehouse

![Status](https://img.shields.io/badge/Status-Staging%20Phase-orange)
![SQL Server](https://img.shields.io/badge/SQL%20Server-T--SQL-blue)
![License](https://img.shields.io/badge/License-MIT-green)

A hands-on data engineering project that builds a PC sales data warehouse pipeline with both staging and cleaned warehouse layers.

---

## 📌 Project Overview

This repository designs and implements a two-layer SQL Server data warehouse pipeline for a PC sales dataset.
The primary goal is to land raw CSV data into SQL Server, build staging objects, and then transform those results into a cleaned warehouse layer with dimensional tables and a fact table.

Key concepts covered:

- Raw data ingestion and staging
- Dimension table creation in staging
- Cleaned warehouse dimension and fact table loading
- Stored procedure orchestration for both layers
- Data profiling, column grouping, and validation

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

This project implements a two-layer warehouse architecture:

1. Raw CSV data is placed in `raw_data/`
2. SQL Server databases are created: `pc_sales_stg` and `pc_sales_dwh`
3. The source dataset is landed into a staging table such as `pc_sales_stg.dbo.Pc_Sales_Dataset_Stg`
4. Staging dimensions and fact load the intermediate model
5. Warehouse/cleaned layer scripts transform staging outputs into final warehouse dimensions and fact records
6. Warehouse validation checks certify the cleaned layer

Both the staging layer and the cleaned warehouse layer are included in this repository.

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

- Staging dimension scripts: `sql_scripts/dim_tables/*.sql`
- Staging fact script: `sql_scripts/fact_table/10.fact_pc_sales_staging.sql`
- Staging procedure wrappers: `sql_scripts/stored_procedures/execute_sp_scripts/*.sql`
- Warehouse dimension scripts: `cleaned_layer_scripts/dim_tables/*.sql`
- Warehouse fact script: `cleaned_layer_scripts/fact_table/10.fact_pc_sales_warehouse.sql`
- Warehouse procedure wrappers: `cleaned_layer_scripts/stored_procedures/execute_sp_scripts/*.sql`
- Warehouse validation: `cleaned_layer_scripts/data_validation/data_quality_checks_warehouse.sql`
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

## ⚡ Quick Start

Run the commands in this order in SQL Server Management Studio:

1. Create the staging/warehouse databases:

```sql
sql_scripts/create_pc_sales_stg_db.sql
```

2. Load the source CSV into `pc_sales_stg.dbo.Pc_Sales_Dataset_Stg`.

3. Build staging dimensions:

```sql
sql_scripts/stored_procedures/execute_sp_scripts/sp_execute_dim_scripts.sql
```

4. Build the staging fact table:

```sql
sql_scripts/stored_procedures/execute_sp_scripts/sp_execute_fact_script.sql
```

5. Build the cleaned warehouse layer:

```sql
cleaned_layer_scripts/stored_procedures/execute_sp_scripts/sp_execute_dim_scripts_warehouse.sql
cleaned_layer_scripts/stored_procedures/execute_sp_scripts/sp_execute_fact_script_warehouse.sql
```

6. Validate the warehouse data:

```sql
cleaned_layer_scripts/data_validation/data_quality_checks_warehouse.sql
```

---

## 📌 Current Status

- Database creation: ✅ Done
- Raw source dataset available: ✅ Done
- Staging dimension and fact scripts: ✅ Available
- Warehouse/cleaned layer scripts: ✅ Included
- Warehouse validation checks: ✅ Included
- End-to-end automation: ⚠️ In progress

---

## 🔍 Notes

- The repository includes both staging objects and the cleaned warehouse layer.
- The cleaned warehouse layer transforms staging outputs into final dimensional models.
- Warehouse validation checks are available under `cleaned_layer_scripts/data_validation/`.
- Quality checks, production orchestration, and deployment-ready automation are next-phase improvements.

---

## 📁 Folder Guide

- `raw_data/` — source CSV dataset
- `sql_scripts/` — staging SQL definitions, procedures, and ETL scripts
- `cleaned_layer_scripts/` — final cleaned warehouse layer scripts and validation checks
- `data_architecture/` — modelling and architecture design artifacts
- `data_planning_docs/` — project documentation, planning, and analysis

---

## ▶️ What is next

1. Load `raw_data/PC_sales_dataset_Stg.csv` into the staging table and run the staging pipeline.
2. Run the cleaned warehouse layer with `cleaned_layer_scripts/stored_procedures/execute_sp_scripts/*.sql`.
3. Execute warehouse validation checks in `cleaned_layer_scripts/data_validation/data_quality_checks_warehouse.sql`.
4. Add automation for source ingestion and end-to-end execution.
5. Document source-to-target mappings, deployment steps, and the final warehouse schema.

---

## 📜 License

This repository is intended for learning and development and is shared under an open/learning-style license.
