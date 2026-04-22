select * from RideBookings;
--DESCRIBE rideBookings;

SELECT top 500 * FROM rideBookings;
SELECT DISTINCT * FROM rideBookings;
SELECT COUNT(*) AS total_rows FROM rideBookings;

--Checking Missing values 

SELECT 
    COUNT(*) AS total_rows,
    COUNT(Avg_VTAT) AS non_null_count,
    COUNT(*) - COUNT(Avg_VTAT) AS null_count
FROM rideBookings;

--Catagory values

SELECT Booking_Status, COUNT(*) AS count
FROM rideBookings
GROUP BY Booking_Status
ORDER BY count DESC;

--MIN,MAX AND AVG

SELECT 
    MIN(Booking_Value) AS min_fare,
    MAX(Booking_Value) AS max_fare,
    AVG(Booking_Value) AS avg_fare
    --STDDEV(Booking_Value) AS std_dev
FROM rideBookings;

--Window functions

--Find first ride per user
SELECT 
    Customer_ID,
    Time as booking_time,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY time) AS ride_number
FROM rideBookings;

--Rank 

SELECT 
    Customer_ID,
    Booking_Value,
    RANK() OVER (ORDER BY booking_value DESC) AS rank
    --DENSE_RANK() OVER (ORDER BY fare DESC) AS dense_rank
FROM rideBookings;

--Dense Rank

SELECT 
    Customer_ID,
    Avg_CTAT,
    DENSE_RANK() OVER (ORDER BY avg_ctat DESC) AS dense_rank
FROM rideBookings;

--Compare current ride fare with previous ride

SELECT 
    Customer_ID,
    Time,
    Booking_Value,
    LAG(Booking_Value) OVER (PARTITION BY customer_id ORDER BY time) AS prev_fare 
FROM rideBookings WHERE Booking_Value IS NOT NULL

---Find Repeat Customers

SELECT *
FROM (
    SELECT 
        Customer_ID,
        COUNT(*) OVER (PARTITION BY customer_id) AS total_rides
    FROM rideBookings
) t
WHERE total_rides > 1;

--Self JOin

DELETE t1
FROM rideBookings t1
JOIN rideBookings t2
  ON t1.Customer_ID = t2.Customer_ID
 AND t1.Time = t2.Time
 AND t1.Booking_Value = t2.Booking_Value
 AND t1.Booking_ID > t2.Booking_ID;