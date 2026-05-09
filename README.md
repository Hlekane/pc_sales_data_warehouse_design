# PC Sales Data Warehouse

A two-layer SQL Server data warehouse pipeline for a PC sales dataset. The project lands raw CSV data into a staging layer, then transforms it into a cleaned warehouse with a star schema; nine dimension tables and a central fact table.

---

## Project overview

This pipeline implements a staging-to-warehouse pattern in T-SQL:

1. Raw CSV data is loaded into a staging database (`pc_sales_stg`)
2. Staging dimension and fact scripts reshape the raw data into an intermediate model
3. Cleaned warehouse scripts (`pc_sales_dwh`) transform the staging output into final dimensional tables
4. Validation checks certify the warehouse layer

Key concepts covered: raw data ingestion, dimension and fact table design, stored procedure orchestration, data profiling, and warehouse validation.

---

## Prerequisites

- SQL Server 2019 or later (Developer or Standard edition)
- SQL Server Management Studio (SSMS) 18+
- Access to run `CREATE DATABASE`, `BULK INSERT`, or the SQL Server Import Wizard

---

## Repository structure

```
pc-sales-dwh/
├── raw_data/
│   └── pc_sales_dataset_Stg.csv           # Source dataset
├── sql_scripts/
│   ├── create_pc_sales_stg_db.sql          # Creates staging and warehouse databases
│   ├── column_grouping_and_data_profiling.sql
│   ├── data_profiling_with_dims.sql
│   ├── dim_tables/                         # Staging dimension scripts
│   ├── fact_table/
│   │   └── 10.fact_pc_sales_staging.sql
│   └── stored_procedures/
│       ├── execute_sp_scripts/             # Execution wrappers
│       └── drop_procedure/                 # Cleanup scripts
├── cleaned_layer_scripts/
│   ├── dim_tables/                         # Warehouse dimension scripts
│   ├── fact_table/
│   │   └── 10.fact_pc_sales_warehouse.sql
│   ├── stored_procedures/
│   │   └── execute_sp_scripts/
│   └── data_validation/
│       └── data_quality_checks_warehouse.sql
├── data_architecture/                      # Architecture design artifacts
└── data_planning_docs/                     # Project planning and analysis
```

---

## Data model

The warehouse uses a star schema with a central fact table and nine dimension tables.

### Dimensions

| Table | Description |
|---|---|
| `Dim_Customer` | Customer attributes |
| `Dim_Product` | PC product details |
| `Dim_Date` | Calendar date dimension |
| `Dim_Salesperson` | Sales staff |
| `Dim_Location` | Geographic location |
| `Dim_Channel` | Sales channel |
| `Dim_Payment_Method` | Payment type |
| `Dim_Priority` | Order priority |
| `Dim_Store` | Store details |

### Fact table

`Pc_Sales_Fact` — measures include `Cost_Price`, `Sale_Price`, `Discount_Amount`, `Finance_Amount`, `Credit_Score`, `Cost_Of_Repairs`, `Total_Sales_Per_Employee`, and `Pc_Market_Price`.

---

## Quick start

Run the following steps in order in SSMS.

### 1. Create the databases

```sql
-- Creates pc_sales_stg and pc_sales_dwh
sql_scripts/create_pc_sales_stg_db.sql
```

### 2. Load the source data

Import `raw_data/pc_sales_dataset_Stg.csv` into `pc_sales_stg.dbo.Pc_Sales_Dataset_Stg` using the Import Wizard, `BULK INSERT`, or `OPENROWSET`.

### 3. Build the staging layer

```sql
-- Create staging dimensions
sql_scripts/stored_procedures/execute_sp_scripts/sp_execute_dim_scripts.sql

-- Create staging fact table
sql_scripts/stored_procedures/execute_sp_scripts/sp_execute_fact_script.sql
```

### 4. Build the warehouse layer

```sql
-- Create warehouse dimensions
cleaned_layer_scripts/stored_procedures/execute_sp_scripts/sp_execute_dim_scripts_warehouse.sql

-- Create warehouse fact table
cleaned_layer_scripts/stored_procedures/execute_sp_scripts/sp_execute_fact_script_warehouse.sql
```

### 5. Validate the warehouse

```sql
cleaned_layer_scripts/data_validation/data_quality_checks_warehouse.sql
```

### Optional: data profiling

```sql
sql_scripts/column_grouping_and_data_profiling.sql
sql_scripts/data_profiling_with_dims.sql
```

---

## Current status

| Layer | Status |
|---|---|
| Database creation | ✅ Done |
| Raw source dataset | ✅ Done |
| Staging dimensions and fact | ✅ Done |
| Warehouse dimensions and fact | ✅ Done |
| Warehouse validation checks | ✅ Done |
| End-to-end automation | ⚠️ In progress |

---

## Roadmap

- [ ] Automate source CSV ingestion (SSIS package or scheduled job)
- [ ] Add end-to-end execution script that runs all layers in a single call
- [ ] Document source-to-target column mappings for each dimension
- [ ] Add deployment guide for non-developer environments
- [ ] Produce final warehouse schema diagram

---

## Notes

- All staging objects live in `pc_sales_stg`; all warehouse objects live in `pc_sales_dwh`.
- The cleaned warehouse layer does not read directly from the CSV — it transforms data already in the staging database.
- Stored procedures can be removed individually using the scripts in `sql_scripts/stored_procedures/drop_procedure/`.

---

## License

This project is shared for learning and development purposes under the MIT License.
