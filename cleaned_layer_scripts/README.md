# Cleaned Layer Scripts

This folder contains all SQL scripts for creating and populating the **cleaned layer** (data warehouse - `pc_sales_dw` database) of the PC Sales Data Warehouse project.

## Folder Structure

```
cleaned_layer_scripts/
├── dim_tables/                              # Dimension table creation scripts
│   ├── 1.dim_customer_warehouse.sql         # Create cleaned dim_customer
│   ├── 2.dim_product_warehouse.sql          # Create cleaned dim_product
│   ├── 3.dim_date_warehouse.sql             # Create cleaned dim_date
│   ├── 4.dim_salesperson_warehouse.sql      # Create cleaned dim_salesperson
│   ├── 5.dim_location_warehouse.sql         # Create cleaned dim_location
│   ├── 6.dim_channel_warehouse.sql          # Create cleaned dim_channel
│   ├── 7.dim_payment_method_warehouse.sql   # Create cleaned dim_payment_method
│   ├── 8.dim_priority_warehouse.sql         # Create cleaned dim_priority
│   └── 9.dim_store_warehouse.sql            # Create cleaned dim_store
│
├── fact_table/                              # Fact table creation script
│   └── 10.fact_pc_sales_warehouse.sql       # Create fact_pc_sales with data joins
│
├── stored_procedures/                       # Stored procedures for dimension creation
│   ├── 1.sp_dim_customer_warehouse.sql      # SP: Create dim_customer in warehouse
│   ├── 2.sp_dim_product_warehouse.sql       # SP: Create dim_product in warehouse
│   ├── 3.sp_dim_date_warehouse.sql          # SP: Create dim_date in warehouse
│   ├── 4.sp_dim_salesperson_warehouse.sql   # SP: Create dim_salesperson in warehouse
│   ├── 5.sp_dim_location_warehouse.sql      # SP: Create dim_location in warehouse
│   ├── 6.sp_dim_channel_warehouse.sql       # SP: Create dim_channel in warehouse
│   ├── 7.sp_dim_payment_method_warehouse.sql# SP: Create dim_payment_method in warehouse
│   ├── 8.sp_dim_priority_warehouse.sql      # SP: Create dim_priority in warehouse
│   ├── 9.sp_dim_store_warehouse.sql         # SP: Create dim_store in warehouse
│   ├── 10.sp_fact_pc_sales_warehouse.sql    # SP: Create fact_pc_sales in warehouse
│   │
│   └── execute_sp_scripts/                  # Execution scripts
│       ├── sp_execute_dim_scripts_warehouse.sql     # Execute all dimension SPs
│       └── sp_execute_fact_script_warehouse.sql     # Execute fact SP
│
└── data_validation/                         # Data quality and validation scripts
    └── data_quality_checks_warehouse.sql    # Row counts, nulls, referential integrity checks
```

## Key Features of Cleaned Layer

### Data Cleaning

- **TRIM()**: Removes leading/trailing whitespace from all string columns
- **ISNULL()**: Handles NULL values by replacing with empty strings or defaults
- **LEN()**: Validates that required fields contain actual data (not just whitespace)

### Data Validation

- **Non-null constraints**: WHERE clauses ensure critical fields have values
- **Numeric validation**: Ensures all numeric fields are >= 0 (no negative values)
- **Referential integrity**: INNER JOINs guarantee fact records only load with valid dimension keys

### Transformation

- **Distinct values**: Removes duplicates from dimensional data
- **Data type preservation**: Maintains proper data types from staging layer

## Execution Order

**Step 1: Create Staging Layer First** (from `sql_scripts/` folder)

```sql
EXEC sp_execute_dim_scripts;        -- Create staging dimensions
EXEC sp_execute_fact_script;        -- Create staging fact table
```

**Step 2: Load Cleaned Layer** (from this folder)

```sql
EXEC sp_execute_dim_scripts_warehouse.sql       -- Load all dimensions to warehouse
EXEC sp_execute_fact_script_warehouse.sql       -- Load fact table to warehouse
```

**Step 3: Validate Data Quality** (from this folder)

```sql
EXEC data_quality_checks_warehouse.sql          -- Run all validation checks
```

## Database and Schema

All scripts target the `pc_sales_dw` database in the `dbo` schema:

- **Staging Source**: `pc_sales_stg.dbo.*`
- **Warehouse Target**: `pc_sales_dw.dbo.*`

## Validation Checks

The `data_quality_checks_warehouse.sql` script performs:

1. **Row Count Summary**: Counts records in all dimensions and fact table
2. **NULL Detection**: Checks for NULLs in all fact table foreign keys
3. **Numeric Validation**: Detects negative values in numeric fields
4. **Referential Integrity**: Finds orphaned fact records (FKs without matching dimension records)

## Notes

- All scripts use `CREATE OR ALTER PROCEDURE` for safe re-execution
- DROP TABLE statements with `IF OBJECT_ID` checks prevent errors on re-runs
- LoadDate GETDATE() captures warehouse load timestamps
- Scripts follow T-SQL and industry-standard SQL formatting conventions
