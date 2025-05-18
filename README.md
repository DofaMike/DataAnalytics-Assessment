SQL assessment completed by Udofa Mfon-abasi Michael

Notes/Challenges
1. confirmed_amount on savings table was used as transaction amount
2. The SQL dump data was too heavy as I had to edit the php.ini and sq config files
3. Foreign key constraints kept throwing error, so I commented it out on the plans and savings tables query in the sql file


Task1: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
Approach: A select query that finds 
  - user identification (ID, Concat(firstname and lastname)
  - count of savings transactions by counting distinct customers with entry into the savings table
  - count of invbestment transactions by counting disting customers with entry into the plans table
  - sum of all confirmed_amount from savings table.
  - 


Task2: Calculate the average number of transactions per customer per month and categorize them:
"High Frequency" (≥10 transactions/month)
"Medium Frequency" (3-9 transactions/month)
"Low Frequency" (≤2 transactions/month)
Approach: A customer transaction function was written to select
  - count of unique customer savings divided by ffrequency of transaction per month t get average transactions per month
  - If average ranaction per month is:
      - greated than 10 then label of high frequency is applied
      - between 3 and 9 then label of medium frequency is applied
      - else it is low frequency
   


Task 3: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .
Approach: A select query that scans trhough plans and savings table to find customer transaction type
  - If entry is found on plans table, a label of investment is applied as type
  - if entry is found on savings table, a label of savings is applied as type
  - Only transactions without NULL values within the last year are considered in the query



Task4: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
 -  Account tenure (months since signup)
  - Total transactions
  - Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
  - Order by estimated CLV from highest to lowest
Approach: 2 sql functions were applied
  - transaction summary: select query to find count of customer transactions and average value from savings table
  - customer tenure: select query that gets time difference between current date and joined_date to find tenure
  - For tenure greateer than 0 month, CLV calculated as total transactions divided by tenure multiplied by 12 months and average transaction value.
