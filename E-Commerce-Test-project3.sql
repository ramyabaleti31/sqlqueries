SELECT top 500 * FROM Global_Ecommerce_Customer_Behavior;

--AVG
SELECT AVG(PurchaseAmount) AS Avg_Purchase_Amount
FROM Global_Ecommerce_Customer_Behavior;

--COUNT
SELECT ProductCategory, COUNT(*) AS Products
FROM Global_Ecommerce_Customer_Behavior where ProductCategory='Books'
GROUP BY ProductCategory 
ORDER BY Products DESC;

--TOP 5
select top 5 * , max(PurchaseAmount) over () from Global_Ecommerce_Customer_Behavior;

--Top Customers
SELECT CustomerID, SUM(PurchaseAmount) AS total_Purchase
FROM Global_Ecommerce_Customer_Behavior GROUP BY CustomerID;

--Yongest and Oldest customers
 
SELECT MIN(Age) AS youngest_age,
    MAX(Age) AS oldest_age
FROM Global_Ecommerce_Customer_Behavior;

--Count of Yongest and Oldest customers
--  SELECT Count(*) as Min_Age 
--    (MIN(Age) AS youngest_age,
--    MAX(Age) AS oldest_age
--FROM Global_Ecommerce_Customer_Behavior;

--Female 

Select * from Global_Ecommerce_Customer_Behavior where Gender='Female' and PaymentMethod='Cash'

--Duplicates

SELECT CustomerID,COUNT(*) AS duplicate_count
FROM Global_Ecommerce_Customer_Behavior
GROUP BY CustomerID, Age, Gender
HAVING COUNT(*) > 1;

--DELETE

DELETE FROM Global_Ecommerce_Customer_Behavior
WHERE PurchaseDate < '2023-01-01';

--QUERY FOR FEMALE HAVING YONGE AGE IN UK AND PAYMENT METHOD AND DEVICE USED IS MOBILE

SELECT *
FROM Global_Ecommerce_Customer_Behavior
WHERE Gender = 'Female'
  AND Location = 'UK'
  AND DeviceUsed = 'Mobile'
  AND Age = ( SELECT MIN(Age)
        FROM Global_Ecommerce_Customer_Behavior
        WHERE Gender = 'Female'
          AND Location = 'UK'
          AND DeviceUsed = 'Mobile');


   -- SELECT 

 --rank based on payment method

 SELECT 
    paymentmethod,
    SUM(purchaseamount) AS total_sales,
    RANK() OVER (ORDER BY SUM(purchaseamount) DESC) AS ranknum
FROM 
    Global_Ecommerce_Customer_Behavior
GROUP BY paymentmethod
ORDER BY total_sales DESC;

go
