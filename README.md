# retail-sales-analytics-postgres
End-to-end retail sales analytics project using PostgreSQL, featuring raw data ingestion, schema auditing, data cleaning, and analytical SQL queries.
## Data Source
This project uses a publicly available retail sales dataset sourced from Kaggle for educational and portfolio purposes.

## Project Structure

/sql  
- 01_raw_ingestion.sql — Load raw CSVs into PostgreSQL  
- 02_schema_audit.sql — Inspect and validate inferred data types  
- 03_clean_orders.sql — Clean and transform orders data  
- 04_clean_products.sql — Clean and standardize product data  
- 05_analysis_queries.sql — Core analytical queries  
- 06_eda.sql — Exploratory data analysis supporting business insights  


## How to Reproduce

1. Load raw CSV files into PostgreSQL using DBeaver or psql  
2. Run scripts in numerical order (01 → 06)  
3. Analysis queries reference cleaned tables in the clean schema  

