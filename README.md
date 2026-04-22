# 🖥️ PC Sales Data Warehouse (ETL Pipeline)

> A hands-on data engineering project demonstrating the design and implementation of a staging layer for a PC sales data warehouse, built with SQL Server and T-SQL.

---

## 📌 Project Overview

This project builds a structured **ETL pipeline** for a fictional PC sales business. The focus is on the foundational layers of data engineering: extracting raw data, staging it safely, validating quality, and preparing it for dimensional modelling using a star schema.

The project is being developed incrementally, reflecting real-world data warehouse practices one phase at a time.

---

## 🗂️ Project Planning — Notion

Project tasks and epics are tracked in Notion, broken down by data warehouse stages with progress indicators.

| Epic | Tasks Defined | Status |
|---|---|---|
| Requirements Analysis | Business requirements scoping | 0% — Not Started |
| Design Data Architecture | Extract method, data exploration, staging layer, star schema design | 0% — Not Started |
| Project Initialisation | Git repo setup ✅, DB & schemas, Notion task board ✅, naming conventions ✅ | 50% — In Progress |

> **Completed so far:** Git repository created and structured, project naming conventions defined, and Notion task board configured with epics and sub-tasks.

---

## ⚙️ ETL Pipeline Phases

| Phase | Description | Status |
|---|---|---|
| **Extract** | Import flat file (CSV) into SQL Server staging tables | 🔄 In Progress |
| **Explore** | Data profiling — quality, completeness, structure, format | 🔄 In Progress |
| **Stage** | Load raw data into the staging database layer | 🔄 In Progress |
| **Validate** | Schema checks, null checks, duplicate detection, type validation | 📋 Planned |
| **Transform** | Cleanse and structure data for dimensional loading | 📋 Planned |
| **Load** | Populate fact and dimension tables | 📋 Planned |
| **Automate** | Schedule workflows using SQL Server Agent | 📋 Planned |

---

## 🗃️ Staging Layer

Raw data is ingested from a flat CSV file into staging tables before any transformation occurs. This preserves the source data and allows for full auditability and reprocessing.

**Stored procedures handle:**
- Creating and resetting staging tables
- Preparing dimension and fact table shells
- Supporting repeatable, automated ETL runs

---

## ✅ Data Validation (Staging Phase)

Before transformation, the following checks are applied to the staged data:

| Check | Description |
|---|---|
| Schema Validation | Correct columns and data types are present |
| Null Checks | Required fields must not be empty |
| Duplicate Detection | No repeated records allowed |
| Data Type Validation | Dates and numeric fields are correctly formatted |
| Row Count Reconciliation | Source CSV row count matches staged row count |
| Referential Sanity | Basic relationship checks between key fields |

---

## 🌟 Star Schema Design

The target dimensional model is a star schema centred on `Fact_PC_Sales`, surrounded by eight dimension tables capturing all analytical context.

<img width="1009" height="893" alt="PC_Data_Modelling" src="https://github.com/user-attachments/assets/acb74278-8c51-46da-8b13-13dac7c3e4af" />


### Fact Table

**`Fact_PC_Sales`** — central table containing all transactional measures and foreign keys.

| Column | Type | Description |
|---|---|---|
| PC_Sales_ID | PK | Unique sale identifier |
| Location_ID | FK | Links to Dim_Location |
| Date_ID | FK | Links to Dim_Date |
| Customer_ID | FK | Links to Dim_Customer |
| SalesPerson_ID | FK | Links to Dim_Salesperson |
| Store_ID | FK | Links to Dim_Store |
| Payment_ID | FK | Links to Dim_Payment |
| Product_ID | FK | Links to Dim_Product |
| Priority_ID | FK | Links to Dim_Priority |
| Channel_ID | FK | Links to Dim_Channel |
| Sales_Price | Measure | Unit sale price |
| Total_Sales | Measure | Total transaction value |
| Credit_Score | Measure | Customer credit score |
| Discount_Amount | Measure | Discount applied |
| Cost_Price | Measure | Product cost price |
| Cost_Of_Repairs | Measure | Post-sale repair cost |

### Dimension Tables

| Dimension | Key Attributes |
|---|---|
| `Dim_Customer` | Customer_Name, Contact_Number, Email, Shipping_Address |
| `Dim_Product` | PC_Make, PC_Model, Storage_Type, RAM, Storage_Capacity |
| `Dim_Date` | Transactional_Date, Ship_Date |
| `Dim_Location` | Continent, Country_Or_State, Province_Or_City |
| `Dim_Store` | Store_Name, Store_Age |
| `Dim_Salesperson` | Salesperson_Name, Department, Sales_Location |
| `Dim_Payment` | Payment_Method |
| `Dim_Channel` | Channel (e.g. Online, In-Store) |
| `Dim_Priority` | Priority level |

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| SQL Server | Database engine |
| T-SQL | Stored procedures and validation logic |
| SSMS | Development and query environment |
| Notion | Project planning and task tracking |
| Draw.io | Star schema design |
| Git / GitHub | Version control |

---

## 📁 Repository Structure

```
pc-sales-data-warehouse/
│
├── docs/
│   └── PC_Data_Modelling.jpg       # Star schema diagram
│
├── staging/
│   ├── create_staging_tables.sql   # Staging table definitions
│   └── stored_procedures.sql       # ETL stored procedures
│
├── validation/
│   └── validation_checks.sql       # Data quality checks
│
├── schema/
│   └── star_schema_ddl.sql         # Dimension and fact table DDL
│
└── README.md
```

---

## 🔜 Next Steps

1. Complete data exploration and document findings
2. Implement validation checks against staged data
3. Build transformation logic to cleanse and standardise records
4. Populate all dimension tables
5. Load `Fact_PC_Sales` with validated, transformed data
6. Introduce automation using SQL Server Agent jobs
7. Build reporting-ready views on top of the star schema

---

## 📝 About

This project is part of a structured self-directed learning journey into **data engineering and data warehousing**. Each phase is planned, tracked, and implemented to reflect real-world ETL practices — from raw data ingestion through to a reporting-ready dimensional model.

