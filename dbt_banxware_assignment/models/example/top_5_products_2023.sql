WITH sales_2023 AS (
    SELECT
        product_id,
        SUM(quantity * price) AS total_sales
    FROM
        {{ ref('transformed_sales_data') }}
    WHERE
        year = 2023
    GROUP BY product_id
)
SELECT
    product_id,
    total_sales
FROM
    sales_2023
ORDER BY
    total_sales DESC
LIMIT 5
