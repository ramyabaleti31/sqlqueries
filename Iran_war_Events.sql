SELECT * FROM iran_war_key_events_timeline

--DUPLICATES
DELETE FROM iran_war_key_events_timeline
WHERE date IS NULL;

--DUPLICATES
DELETE FROM iran_war_key_events_timeline
WHERE description IS NULL;


--lIKE OPRATOR
SELECT * FROM iran_war_key_events_timeline WHERE event_title LIKE '%BRENT%'

--Category rank
SELECT 
    event_title,
    brent_price_that_day,
    RANK() OVER (ORDER BY brent_price_that_day DESC) AS rank_price
FROM iran_war_key_events_timeline;

--left join

SELECT 
    O.date,
    O.gas_change_from_prewar_dollars AS oil_price,
    W.description
FROM iran_war_oil_prices_daily_2026 O
LEFT JOIN iran_war_key_events_timeline W
ON O.date = W.date --where description != Null
ORDER BY O.date;

--Inner JOin

SELECT 
    O.date,
    O.gas_change_from_prewar_dollars AS oil_price,
    W.description
FROM iran_war_oil_prices_daily_2026 O
INNER JOIN iran_war_key_events_timeline W
ON O.date = W.date --where description != Null
ORDER BY O.date;


