WITH sales AS (
    SELECT
        order_id,
        customer_id,
        product_id,
        quantity,
        price,
        DATE(order_date) AS order_date,  -- Convert order_date to DATE type if not already
        EXTRACT(YEAR FROM order_date) AS year,
        EXTRACT(MONTH FROM order_date) AS month,
        EXTRACT(DAY FROM order_date) AS day,
        quantity * price AS total_sales,  -- Calculating total sales
        order_status 
    FROM
        {{ ref('raw_sales_data') }}
)

SELECT
    *
    -- CASE
    --     WHEN order_status = 'Pending' THEN 'In Process'
    --     ELSE order_status
    -- END AS order_status_adjusted
FROM sales