WITH sales_2023 AS (
    SELECT
        t1.customer_id, 
        t2.name,
        SUM(t1.quantity * t1.price) AS total_sales
    FROM
        {{ ref('transformed_sales_data') }} AS t1
    LEFT JOIN 
        {{ ref('raw_customer_data') }} AS t2 
    ON 
        t1.customer_id = t2.id
    WHERE
        t1.year = 2023
    GROUP BY 
        t1.customer_id, 
        t2.name
)
SELECT
    customer_id, 
    name,
    total_sales
FROM
    sales_2023
ORDER BY
    total_sales DESC
LIMIT 5