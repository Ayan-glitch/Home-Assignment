WITH sales_2023 AS (
    SELECT
        month,
        order_id,
        SUM(quantity * price) AS total_order_value
    FROM
        {{ ref('transformed_sales_data') }}
    WHERE
        year = 2023
    GROUP BY month, order_id
)
SELECT
    month,
    AVG(total_order_value) AS avg_order_value
FROM
    sales_2023
GROUP BY month
ORDER BY month