# PC Sales Data Warehouse (Staging Layer)

## Overview
This project demonstrates the design and implementation of a **staging layer** for a PC sales data warehouse using SQL Server.

The focus is on structuring raw data for downstream processing, ensuring data quality, and preparing for dimensional modelling (star schema).

---

## Objectives
- Build a structured **staging environment**
- Apply **data validation techniques**
- Prepare data for **transformation and loading**
- Implement **stored procedures** for repeatable processes

---

## Project Structure

### Staging Tables
Raw data is loaded into staging tables before transformation.

### Stored Procedures
- Create dimension tables
- Create fact table
- Handle table resets (drop & recreate)
- Prepare for automated ETL workflows

---

## Data Validation (Staging Phase)
Validation is performed before transformation to ensure data quality.

Key checks include:
- Schema validation (correct columns and data types)
- Null checks on required fields
- Duplicate detection
- Data type validation (dates, numeric values)
- Row count reconciliation
- Basic referential sanity checks

---

## Star Schema (Planned)
The project is designed to evolve into a star schema:

- **Fact Table**
  - PC_Sales_Fact

- **Dimension Tables**
  - Dim_Customer
  - Dim_Product
  - Dim_Date
  - Dim_Channel

![Star Schema](docs/star_schema.png)

---

## Tech Stack
- **SQL Server**
- **T-SQL (Stored Procedures)**
- **SQL Server Management Studio (SSMS)**

---

## Project Plan

| Phase                | Description                                      | Status        |
|---------------------|--------------------------------------------------|--------------|
| Data Extraction     | Load raw data into staging tables               | Completed     |
| Data Validation     | Perform quality checks on staged data           | In Progress   |
| Data Transformation | Clean and structure data for analytics          | Planned       |
| Data Loading        | Load into fact and dimension tables             | Planned       |
| Automation          | Schedule workflows (SQL Server Agent)           | Planned       |

---

## Key Concepts Demonstrated
- Staging layer design in ETL
- Data validation before transformation
- Use of stored procedures for data management
- Foundations of dimensional modelling

---

## Next Steps
- Implement transformation logic
- Populate dimension and fact tables
- Introduce automation using SQL Server Agent
- Build reporting-ready data structures

---

## Notes
This project is part of a learning journey into **data engineering and data warehousing**, focusing on building practical, real-world skills step by step.
