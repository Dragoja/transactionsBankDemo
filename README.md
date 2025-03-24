# transactionsBankDemo
# Requirements
- Microsoft SQL Server – Azure SQL Server
- SQL Server Management Studio
- Linux server – Ubuntu 24.04
- Python v3.9 or above
- Python editor - PyCharm
- SSH client software – Maxterm
- Git Repository
- Postman
- DrawIO

## Project Overview
### This project involves:
- **Data Architecture:** Designing a Data Warehouse Using Source, Staging, and Datawarehouse layers.
- **ETL Pipelines:** Extracting, transforming, and loading data from source systems into the warehouse.
- **Data Modeling:** Developing fact, dimension, and mart tables optimized for analytical queries.

### Objective
Develop a modern data warehouse using Azure SQL Server to consolidate transaction data, enabling analytical reporting and informed decision-making.

### Specifications
- **Data Sources:** Import data from API provided by Mplus Serbia.
- **Data Quality:** Cleanse and resolve data quality issues prior to analysis.
- **Scope:** Transforming source data into a user-friendly data model designed for analytical queries.
- **Documentation:** Provide clear documentation of the data model to support both business stakeholders and analytics teams.

---

## Naming Conventions
### Table of Contents
1. General Principles
2. Table Naming Conventions
   - Source Rules
   - Staging Rules
   - Datawarehouse Rules
3. Stored Procedure

---

### General Principles
- **Naming Conventions:** Use snake_case, with lowercase letters and underscores (_) to separate words.
- **Language:** Use English for all names.
- **Avoid Reserved Words:** Do not use SQL reserved words as object names.

---

### Table Naming Conventions
#### Source Rules
- `<sourcesystem>_<entity>`
  - `<sourcesystem>`: Name of the source system (e.g., mplus).
  - `<entity>`: Table name from the source system.
  - Example: `mplus_transactions` → Transaction information from the Mplus system.

#### Staging Rules
- `<sourcesystem>_<entity>`
  - `<sourcesystem>`: Name of the source system (e.g., mplus).
  - `<entity>`: Table name from the source system.
  - Example: `mplus_transactions` → Transaction information from the Mplus system.

#### Datawarehouse Rules
- All names must use meaningful, business-aligned names for tables, starting with the category prefix.
- `<category>_<entity>`
  - `<category>`: Describes the role of the table, such as `dim` (dimension), `fact` (fact table) or `mart` (mart table).
  - `<entity>`: Descriptive name of the table, aligned with the business domain (e.g., city, card_type, gender).
  - Examples:
    - `dim_city` → Dimension table for city data.
    - `fact_transactions` → Fact table containing sales transactions.

---

### Glossary of Category Patterns
| Pattern | Meaning               | Example(s)                         |
|---------|-----------------------|-------------------------------------|
| dim_    | Dimension table       | dim_city, dim_gender, dim_card_type |
| fact_   | Fact table            | fact_transactions                  |
| mart_   | Report table          | mart_expenditure_by_city, mart_card_usage_by_city |

---

### Stored Procedure
- All stored procedures used for loading data must follow the naming pattern:
  - `load_<layer>`
    - `<layer>`: Represents the layer being loaded, such as `Source`, `Staging`, and `Datawarehouse`.
    - Example:
      - `load_stg` → Stored procedure for loading data into the Staging layer.
      - `load_dwh` → Stored procedure for loading data into the DWH layer.
     
### High Level Architecture Diagram
![image](https://github.com/user-attachments/assets/1e2b8963-f437-40a1-84b0-55bf2282dca9)

### Data Flow
![image](https://github.com/user-attachments/assets/1bcf2019-2c9c-4706-873a-8cf1c59bf879)


### Azure SQL Server
Deployment of Azure SQL Server and database

# SQL Queries

## Create Database and Schemas
- Create SQL Database “Bank” and Schemas
- File: `1-Create DB.sql`

## Create Table
- Create SQL Tables on “Bank” Database
- File: `2-Create Tables.sql`

## Load stg.sql
- Create Procedure for normalizing and loading `src` to `stg`
- File: `3-Load stg.sql`

## Load dwh.sql
- Create Procedure for making `dim` and `fact` tables and loading `stg` to `dwh`
- File: `4-Load dwh.sql`

## Load mart.sql
- Create Procedure for making mart tables and loading
