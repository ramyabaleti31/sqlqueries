Select * from [Campaigns]

--DUPLICATES
DELETE FROM Products
WHERE Category IS NULL;

DELETE FROM customers 
WHERE customer_id IS NULL;

DELETE FROM transactions 
WHERE customer_id IS NULL OR product_id IS NULL;

DELETE FROM events 
WHERE customer_id IS NULL OR campaign_id IS NULL;

DELETE FROM Campaigns
WHERE objective IS NULL;

--Duplicates --select * from customers

SELECT customer_id, COUNT(*) AS customer_count
FROM customers
GROUP BY customer_id
HAVING customer_id > 1;


--Removing unwanted Data

DELETE FROM customers WHERE age < 10 OR age > 100;
DELETE FROM transactions WHERE quantity <= 0;


--InnerJoins

SELECT 
    SUM(t.quantity * p.base_price) AS total_revenue
FROM transactions t
JOIN products p
ON t.product_id = p.product_id;


--Categorize Customers using CASE

SELECT 
    customer_id,
    age,
    CASE 
        WHEN age < 25 THEN 'Young'
        WHEN age BETWEEN 25 AND 45 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group
FROM customers;

--Row number -- Select * from transactions

SELECT *
FROM (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id, product_id, timestamp
            ORDER BY transaction_id
        ) AS rn
    FROM transactions
) t
WHERE rn < 1;

--In campaign which customer purchased most products , device type, transaction type
--In campaign which customer purchased most products , device type, transaction type

SELECT * FROM PRODUCTS P
SELECT * FROM CUSTOMERS C
SELECT * FROM EVENTS E
SELECT * FROM CAMPAIGNS CP
SELECT * FROM TRANSACTIONS T

SELECT top 5
    cp.campaign_id,
    c.customer_id,
    e.device_type,
    t.transaction_id,
    c.loyalty_tier,
    cp.channel,
    p.category,
    COUNT(t.transaction_id) AS total_purchases

FROM customers c
JOIN events e ON c.customer_id = e.customer_id
JOIN campaigns cp ON e.campaign_id = cp.campaign_id
JOIN Products p ON e.product_id = p.product_id
JOIN transactions t 
    ON c.customer_id = t.customer_id
    AND t.timestamp BETWEEN cp.start_date AND cp.end_date

GROUP BY 
    p.category,
    cp.campaign_id,
    c.customer_id,
    e.device_type,
    t.transaction_id,
    c.loyalty_tier,
    cp.channel
   
ORDER BY total_purchases DESC
--LIMIT 5;