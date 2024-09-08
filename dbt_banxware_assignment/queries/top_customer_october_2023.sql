WITH october_2023_sales AS (
    SELECT
        customer_id,
        SUM(quantity) AS total_order_volume
    FROM
        {{ ref('transformed_sales_data') }}
    WHERE
        year = 2023 AND month = 10
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_order_volume
FROM
    october_2023_sales
ORDER BY
    total_order_volume DESC
LIMIT 1