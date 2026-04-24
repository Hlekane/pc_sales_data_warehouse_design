# 🖥️ PC Sales Data Warehouse

![Status](https://img.shields.io/badge/Status-Staging%20Phase-orange)
![SQL Server](https://img.shields.io/badge/SQL%20Server-T--SQL-blue)
![License](https://img.shields.io/badge/License-MIT-green)

A data engineering project focused on building a solid and scalable ETL pipeline for a PC sales business. The project is being developed incrementally — currently at the staging phase, which forms the foundation of any reliable data pipeline.

---

## 📌 Overview

This project is a hands-on learning journey through the core disciplines of data engineering. The current focus is the **data landing and staging layer** — the critical first step in building a pipeline that is clean, auditable, and scalable.

The staging layer is where raw source data lands before anything else happens to it. Getting this right matters: a well-structured staging layer protects the integrity of everything downstream, from validation through to the final dimensional model.

The transformation and extraction layers will be built out as the project progresses.

---

## 📍 Current Focus — Staging Layer

The staging phase is the active area of development. This is where raw CSV data is ingested into SQL Server and prepared for downstream processing.

**What is being built at this stage:**

- Staging tables that receive raw source data as-is, without modification
- Stored procedures to create, reset, and reload staging tables between pipeline runs
- A repeatable and automated ingestion process that can be rerun cleanly at any point

> The staging layer is intentionally kept separate from any transformation logic. Its only job is to land data safely and preserve it exactly as it arrived from the source.

---

## ⚙️ Pipeline Phases

| Phase | Description | Status |
|---|---|---|
| **Extract** | Define extraction method and source file handling | 📋 Planned |
| **Stage** | Land raw CSV data into SQL Server staging tables | 🔄 In Progress |
| **Validate** | Apply schema, null, duplicate and type checks against staged data | 📋 Planned |
| **Transform** | Cleanse and standardise data for dimensional loading | 📋 Planned |
| **Load** | Populate fact and dimension tables | 📋 Planned |
| **Automate** | Schedule ETL workflows using SQL Server Agent | 📋 Planned |

---

## 🗃️ Staging Layer — Detail

Raw source data is loaded into staging tables before any transformation is applied. This preserves the original data, supports full auditability, and allows the pipeline to be reprocessed without data loss.

Stored procedures handle:

- Creating and resetting staging tables between pipeline runs
- Preparing dimension and fact table shells for loading
- Supporting repeatable, automated ETL execution

---

## ✅ Data Validation *(Planned)*

Once staging is complete, the following checks will be applied to the staged data before any transformation begins:

| Check | Description |
|---|---|
| Schema Validation | Confirm correct columns and data types are present |
| Null Checks | Verify that required fields contain values |
| Duplicate Detection | Identify and reject repeated records |
| Data Type Validation | Confirm date and numeric fields are correctly formatted |
| Row Count Reconciliation | Verify that the staged row count matches the source CSV |
| Referential Sanity | Perform basic relationship checks between key fields |

---

## 🌟 Star Schema Design *(Target Model- data warehouse)*

The intended dimensional model is a star schema centred on `Fact_PC_Sales`, supported by eight dimension tables. This will be built out during the load phase.

<img width="1009" height="893" alt="pc_data_modelling" src="https://github.com/user-attachments/assets/bff544ee-7809-4aac-b8e8-2d4a8e7d1cb7" />


### Fact Table — `Fact_PC_Sales`

| Column | Type | Description |
|---|---|---|
| PC_Sales_ID | PK | Unique identifier for each sale |
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
| Credit_Score | Measure | Customer credit score at time of sale |
| Discount_Amount | Measure | Discount applied to the transaction |
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
| `Dim_Priority` | Priority Level |

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| SQL Server | Database engine |
| T-SQL | Stored procedures and pipeline logic |
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
│   └── validation_checks.sql       # Data quality checks (planned)
│
├── schema/
│   └── star_schema_ddl.sql         # Dimension and fact table DDL (planned)
│
└── README.md
```

---

## 🚀 Getting Started

### Prerequisites

- SQL Server (2019 or later recommended)
- SQL Server Management Studio (SSMS)

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/pc-sales-data-warehouse.git
   ```

2. Open SSMS and connect to your SQL Server instance.

3. Run the staging table definitions:
   ```sql
   -- staging/create_staging_tables.sql
   ```

4. Execute the stored procedures to initialise the staging layer:
   ```sql
   -- staging/stored_procedures.sql
   ```

5. Place your source CSV file in the expected directory and run the extract step to land data into the staging tables.

---

## 🗂️ Project Status

| Epic | Status |
|---|---|
| Requirements Analysis | ✅ Complete |
| Architecture Design | ✅ Complete |
| Project Initialisation | ✅ Complete |
| Staging Layer | 🟡 In Progress |
| Validation | ⚪ Planned |
| Transformation Layer | ⚪ Planned |
| Extraction Layer | ⚪ Planned |
| Load | ⚪ Planned |
| Automation | ⚪ Planned |

---

## 🔜 Roadmap

This project is being built one layer at a time. Each phase will be completed and documented before the next begins.

1. ✅ Set up repository, naming conventions and project board
2. ✅ Design star schema and define target dimensional model
3. 🔄 Build and validate the staging layer *(current)*
4. ⚪ Implement data validation checks against staged data
5. ⚪ Build the transformation layer
6. ⚪ Build the extraction layer
7. ⚪ Load dimension and fact tables
8. ⚪ Automate pipeline using SQL Server Agent

---

## 📝 About

This project is a structured, learning path through data engineering and data warehousing. The focus at each stage is depth over speed — understanding why each layer exists and how it contributes to a pipeline that is reliable, scalable, and maintainable.
