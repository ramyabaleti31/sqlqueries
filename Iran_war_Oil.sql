SELECT * FROM iran_war_oil_prices_daily_2026

DELETE FROM iran_war_oil_prices_daily_2026
WHERE date IS NULL OR gas_change_from_prewar_dollars  IS NULL;

--Order by
SELECT * FROM iran_war_oil_prices_daily_2026
ORDER BY date;

--Avg
SELECT date , (AVG(gas_change_from_prewar_dollars)) AS avg_oil_price
FROM iran_war_oil_prices_daily_2026;

--Day-to-Day chnage
SELECT 
    date,
    gas_change_from_prewar_dollars,
    gas_change_from_prewar_dollars - LAG(gas_change_from_prewar_dollars) OVER (ORDER BY date) AS daily_change
FROM iran_war_oil_prices_daily_2026;

--Joins

SELECT 
    g.state,
    g.gas_price_mar19_2026 AS gas_price,
    (SELECT AVG(gas_change_from_prewar_dollars) FROM iran_war_oil_prices_daily_2026) AS avg_oil_price,
    g.gas_price_mar19_2026 - (SELECT AVG(gas_change_from_prewar_dollars) FROM iran_war_oil_prices_daily_2026) AS deviation
FROM iran_war_gas_prices_by_state g;