SELECT * FROM iran_war_gas_prices_by_state

--Data Cleaning / Removing the Duplicates 

DELETE FROM iran_war_gas_prices_by_state
WHERE state IS NULL;

-- Remove NULLs
DELETE FROM iran_war_gas_prices_by_state
WHERE state IS NULL OR gas_price_mar19_2026  IS NULL;

-- Standardize state names
UPDATE iran_war_gas_prices_by_state
SET state = TRIM(Lower(state));

-- Remove unrealistic values
DELETE FROM iran_war_gas_prices_by_state
WHERE gas_price_mar19_2026 < 1 OR gas_price_mar19_2026 > 10;

--Min, Max and Avg of Prices
SELECT 
    MIN(gas_price_mar19_2026) AS min_mar_price,
    MAX(gas_price_jan08_2026 ) AS max_jan_price,
    AVG(gas_price_prewar_feb27) AS avg_prewar_price
FROM iran_war_gas_prices_by_state;

-- Top 5 Expensive states
SELECT top 5 state,gas_price_jan08_2026
FROM iran_war_gas_prices_by_state
ORDER BY gas_price_jan08_2026 DESC;-- LIMIT 5

-- Top 5 Lowest States
SELECT top 5 state, gas_price_mar19_2026
FROM iran_war_gas_prices_by_state
--ORDER BY gas_price_mar19_2026 ASC
ORDER BY gas_price_mar19_2026 DESC
--LIMIT 5;

--Rank
SELECT state, gas_price_jan08_2026,
    RANK() OVER (ORDER BY gas_price_jan08_2026 DESC) AS rank_price
FROM iran_war_gas_prices_by_state;

--Dense Rank
SELECT state, gas_price_mar19_2026,
    DENSE_RANK() OVER (ORDER BY gas_price_mar19_2026 DESC) AS dense_rank_price
FROM iran_war_gas_prices_by_state;

--States Above Average Price

SELECT * FROM iran_war_gas_prices_by_state
WHERE gas_price_mar19_2026 > (SELECT AVG(gas_price_mar19_2026) FROM iran_war_gas_prices_by_state);

--