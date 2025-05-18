WITH customer_txn_function AS (
    SELECT 
        c.id AS customer_id,
        c.name,
        COUNT(t.savings_id) * 1.0 / COUNT(DISTINCT MONTH(t.transaction_date)) AS avg_transactions_per_month,
        CASE 
            WHEN COUNT(t.savings_id) * 1.0 / COUNT(DISTINCT MONTH(t.transaction_date)) >= 10 THEN 'High Frequency'
            WHEN COUNT(t.savings_id) * 1.0 / COUNT(DISTINCT MONTH(t.transaction_date)) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM 
        users_customuser c
    JOIN 
        savings_savingsaccount t ON c.id = t.owner_id
    GROUP BY 
        c.id, c.name
)

SELECT 
    frequency_category,
    COUNT(customer_id) AS customer_count,
    AVG(avg_transactions_per_month) AS avg_transactions_per_month
FROM 
    customer_txn_function
GROUP BY 
    frequency_category
ORDER BY 
    avg_transactions_per_month DESC;