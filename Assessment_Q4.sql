WITH txn_summary AS (
    SELECT 
        sa.owner_id,
        COUNT( sa.savings_id) AS total_transactions,
        AVG(sa.confirmed_amount) AS avg_txn_value
    FROM 
        savings_savingsaccount sa
    GROUP BY 
        sa.owner_id
),
user_tenure AS (
    SELECT 
        u.id AS customer_id,
        CONCAT(u.first_name, ' ', u.last_name) as name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) AS tenure_months
    FROM 
        users_customuser u
)
SELECT 
    u.customer_id,
    u.name,
    u.tenure_months,
    COALESCE(t.total_transactions, 0) AS total_transactions,
    ROUND(
        CASE 
            WHEN u.tenure_months > 0 THEN 
                (COALESCE(t.total_transactions, 0) / u.tenure_months) * 12 * (COALESCE(t.avg_txn_value, 0) * 0.001)
            ELSE 0
        END
    , 2) AS estimated_clv
FROM 
    user_tenure u
LEFT JOIN 
    txn_summary t ON u.customer_id = t.owner_id
ORDER BY 
    estimated_clv DESC;