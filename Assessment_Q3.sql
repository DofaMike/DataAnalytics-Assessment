SELECT 
    p.id AS plan_id,
    sa.owner_id,
    CASE 
            WHEN sa.plan_id THEN 'Investments'
            ELSE 'Savings'
END AS type,
   DATE_FORMAT(MAX(sa.transaction_date), "%Y-%m-%d") AS last_transaction_date,
    DATEDIFF(CURRENT_DATE, MAX(sa.transaction_date)) AS inactivity_days
FROM 
    plans_plan p
JOIN 
    savings_savingsaccount sa ON p.id = sa.plan_id
GROUP BY 
    p.id, sa.owner_id
HAVING 
    last_transaction_date IS NULL 
    OR last_transaction_date < CURRENT_DATE - INTERVAL 365 DAY
ORDER BY 
    inactivity_days DESC;