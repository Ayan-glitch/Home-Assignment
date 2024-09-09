- **How to Run**:
  1. Clone the GitHub repository.
  2. Set up Snowflake credentials in `profiles.yml`.
  3. Run `dbt seed` to ingest data.
  4. Run `dbt run` to apply transformations.


## Prerequisites
To run this project, the following prerequisites are needed:

1. **Snowflake account**:
   - The project is configured for Snowflake as the target data warehouse. You can [sign up for a free Snowflake account here](https://signup.snowflake.com/).
2. **dbt (Data Build Tool)**:
   - [Install dbt](https://docs.getdbt.com/docs/installation) locally if you haven't already.
   - Make sure you have dbt installed by running:
     ```bash
     dbt --version
     ```

## Step-by-Step Instructions

### 1. Clone the Project Repository
First, clone the GitHub repository to your local machine
```

### 2. Configure the Connection to Snowflake
You need to set up dbt to connect to your Snowflake account by configuring the `profiles.yml` file. Follow these steps:

1. Create a `profiles.yml` file in your `~/.dbt/` directory (or update the existing one).
   
   **Example `profiles.yml` configuration:**
   ```yaml
   your_project_name:
     outputs:
       dev:
         type: snowflake
         account: <your_snowflake_account>
         user: <your_snowflake_user>
         password: <your_snowflake_password>
         role: <your_snowflake_role>
         database: <your_database_name>
         schema: <your_schema_name>
         warehouse: <your_warehouse_name>
         threads: 4
     target: dev
   ```

2. Replace the values inside the `<>` with your actual Snowflake details:
   - `<your_snowflake_account>`: Your Snowflake account details (e.g., `abc123.snowflakecomputing.com`).
   - `<your_snowflake_user>`: Your Snowflake username.
   - `<your_snowflake_password>`: Your Snowflake password.
   - `<your_snowflake_role>`: The Snowflake role you want to use (e.g., `SYSADMIN`).
   - `<your_database_name>`: The database in Snowflake you want to use for this project.
   - `<your_schema_name>`: The schema name within the Snowflake database.
   - `<your_warehouse_name>`: The warehouse to run the queries.

3. Verify the connection with the following command:

```bash
dbt debug
```

### 3. Seed the Data (Load CSV Files)
Use the `dbt seed` command to load the provided CSV files into Snowflake:

```bash
 dbt seed --profile banxware_assignment
```

This will load the `sales.csv` and `customers.csv` into the Snowflake tables `raw_sales_data` and `raw_customer_data`.

### 4. Run the Data Models
After the data has been seeded, run the dbt models to transform the raw data:

```bash
dbt run --select transformed_sales_data
```

This will generate the transformed tables such as `transformed_sales_data` and `transformed_customer_data`.

### 5. Run Analysis Queries as Models
The analysis queries (e.g., Top 5 Products, Top 5 Customers) have been added as models. You can run each of these models individually or all together:

1. **Top 5 Products by Total Sales in 2023**:
   ```bash
   dbt run --select top_5_products_2023
   ```

2. **Top 5 Customers by Total Sales in 2023**:
   ```bash
   dbt run --select top_5_customers_2023
   ```

3. **Average Order Value for Each Month in 2023**:
   ```bash
   dbt run --select avg_order_value_2023
   ```

4. **Customer with the Highest Order Volume in October 2023**:
   ```bash
   dbt run --select top_customer_october_2023
   ```
