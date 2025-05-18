SELECT 
    b.owner_id, 
    CONCAT(a.first_name, ' ', a.last_name) AS name,  
    COUNT(DISTINCT b.savings_id) AS savings_count, 
    COUNT(DISTINCT c.id) AS investment_count, 
    SUM(b.confirmed_amount) AS total_deposits
FROM users_customuser a
INNER JOIN savings_savingsaccount b ON a.id = b.owner_id
LEFT JOIN plans_plan c ON a.id = c.owner_id
GROUP BY b.owner_id, a.first_name, a.last_name
ORDER BY total_deposits;
