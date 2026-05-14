# PC Sales Data Warehouse – Business Requirements

## Business Objective

Build a centralized analytical warehouse for PC sales data that supports reporting and decision-making. The solution transforms raw CSV sales records into a validated star-schema model for sales, product, customer, channel, and geography analysis.

## Scope

- Source: `raw_data/PC_sales_dataset_Stg.csv`
- Platform: SQL Server 2019+
- Architecture: two-layer ETL pipeline
  - Staging database: `pc_sales_stg`
  - Warehouse database: `pc_sales_dwh`
- Output: clean dimensions + fact table for analytics
- Exclusions: real-time analytics, cloud deployment, automated scheduling

## Data Sources

- Single transactional PC sales CSV
- Includes customer, product, store, location, payment, channel, priority, dates, and financial measures

## Warehouse Model

**Star schema with 1 fact table + 9 dimension tables**

- `Dim_Customer`
- `Dim_Product`
- `Dim_Date`
- `Dim_Salesperson`
- `Dim_Location`
- `Dim_Channel`
- `Dim_Payment_Method`
- `Dim_Priority`
- `Dim_Store`

**Fact table**

- `Pc_Sales_Fact`
- Measures: `Cost_Price`, `Sale_Price`, `Discount_Amount`, `Finance_Amount`, `Credit_Score`, `Cost_Of_Repairs`, `Total_Sales_Per_Employee`, `Pc_Market_Price`

## Key Artifacts

- [Star schema diagram](data_architecture/pc_data_modelling.jpg)
- [Project overview](README.md)
- [Warehouse validation script](cleaned_layer_scripts/data_validation/data_quality_checks_warehouse.sql)
- [Warehouse fact load script](cleaned_layer_scripts/fact_table/10.fact_pc_sales_warehouse.sql)
- [Warehouse dimension scripts](cleaned_layer_scripts/dim_tables/)
- [Warehouse execution wrapper](cleaned_layer_scripts/stored_procedures/execute_sp_scripts/sp_execute_dim_scripts_warehouse.sql)

## Validation & Quality Checks

Yes — validation is implemented and documented.

- Warehouse validation script: `cleaned_layer_scripts/data_validation/data_quality_checks_warehouse.sql`
- Data quality checks include:
  - missing or invalid dimensions
  - orphaned fact records
  - negative-value detection
  - row count consistency
- Warehouse fact script includes validation logic for numeric fields and referential integrity

## Current Status

- Database creation: complete
- Raw source dataset: complete
- Staging layer: complete
- Warehouse layer: complete
- Warehouse validation: complete
- End-to-end automation: in progress

## Next Steps

1. Automate CSV ingestion
2. Build single-step deployment script
3. Document source-to-target mappings
4. Add operational runbooks and a schema diagram explanation
