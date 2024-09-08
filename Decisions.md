# Data Engineering Home Assignment - DECISIONS.md

## 1. Environment Setup

- **Tools Used**:  
  - **Snowflake** for cloud data warehouse.
  - **dbt (data build tool)** for building and managing data models.
  - **CSV files** provided: `sales.csv` and `customers.csv`.

- **Steps Taken**:  
  - Created a new Snowflake account and set up a database named `home_assignment`.
  - Installed dbt and configured the connection to Snowflake using the `profiles.yml` file.
    - **Key Configuration**:  
      `profiles.yml` setup included details like Snowflake account details, database, warehouse, schema, and role.
    - Verified the connection to Snowflake using `dbt debug` to ensure successful integration.

## 2. Data Ingestion

- **Ingestion Process**:
  - **Files**:  
    `sales.csv` and `customers.csv`.
  - Used `dbt seed` to ingest the data into Snowflake as tables:
    - `raw_sales_data`
    - `raw_customer_data`

- **Key Decisions**:  
  - CSV files were placed in the `seeds/` folder for dbt to recognize and load them.
  - Defined column types in `dbt_project.yml` to ensure correct data types in Snowflake. This helped prevent issues with type mismatches during transformation.

  **Example Configuration**:
  ```yaml
  seeds:
    banxware_assignment:
      raw_sales_data:
        +column_types:
          order_id: NUMBER(38,0)
          order_date: DATE
          customer_id: NUMBER(38,0)
          product_id: NUMBER(38,0)
          product_name: VARCHAR(256)
          quantity: NUMBER(38,0)
          price: FLOAT
          order_status: VARCHAR(128)
      raw_customer_data:
        +column_types:
          id: NUMBER(38,0)
          name: VARCHAR(256)
  ```

## 3. Data Transformation

- **Objective**: To transform the raw data into a more structured and analysis-ready format.

### Transformation of `raw_sales_data`:
  - Extracted `year`, `month`, and `day` from the `order_date` column for easy time-based analysis.
  - Calculated the `total_sales` amount by multiplying `quantity` and `price`.

  **Key SQL Logic**:
  ```sql
  WITH sales AS (
      SELECT
          order_id,
          customer_id,
          product_id,
          quantity,
          price,
          DATE(order_date) AS order_date,
          EXTRACT(YEAR FROM order_date) AS year,
          EXTRACT(MONTH FROM order_date) AS month,
          EXTRACT(DAY FROM order_date) AS day,
          quantity * price AS total_sales
      FROM
          {{ ref('raw_sales_data') }}
  )

  SELECT *
  FROM sales
  ```

- **Key Decisions**:
  - Ensured data types were preserved during transformation (e.g., `DATE` for order dates).
  - Used dbt's `ref()` function to refer to raw tables during transformation, ensuring modularity and reusability of code.

## 4. Queries for Analysis

1. **Top 5 Products by Total Sales in 2023**:
   - Query aggregates sales by product and filters for the year 2023.
   - Used `ORDER BY` and `LIMIT` to get the top 5 products.

2. **Top 5 Customers by Total Sales in 2023**:
   - Query aggregates sales by customer name and filters for the year 2023.
   - Sorted by total sales amount.

3. **Average Order Value for Each Month in 2023**:
   - Calculated total sales per month and average order value.
   - Filtered for 2023 and grouped by `month`.

4. **Customer with the Highest Order Volume in October 2023**:
   - Filtered data for October 2023 and calculated the customer with the highest `quantity` ordered.


