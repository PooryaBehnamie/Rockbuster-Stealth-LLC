EXPLAIN
WITH TopCountries AS (
    SELECT  CO.country
    FROM    customer C
    JOIN    address add ON C.address_id = add.address_id
    JOIN    city CI ON add.city_id = CI.city_id
    JOIN    country CO ON CI.country_id = CO.country_id
    GROUP BY CO.country
    ORDER BY COUNT(DISTINCT C.customer_id) DESC
    LIMIT 10
),
TopCities AS (
    SELECT  CI.city, CO.country
    FROM    customer C
    JOIN    address add ON C.address_id = add.address_id
    JOIN    city CI ON add.city_id = CI.city_id
    JOIN    country CO ON CI.country_id = CO.country_id
    WHERE   CO.country IN (SELECT country FROM TopCountries)
    GROUP BY CI.city, CO.country
    ORDER BY COUNT(DISTINCT C.customer_id) DESC
    LIMIT 10
),
TopCustomers AS (
    SELECT  C.customer_id,
            C.first_name,
            C.last_name,
            CO.country,
            CI.city,
            SUM(P.amount) AS Total_Amount
    FROM    payment P
    JOIN    customer C ON P.customer_id = C.customer_id
    JOIN    address add ON C.address_id = add.address_id
    JOIN    city CI ON add.city_id = CI.city_id
    JOIN    country CO ON CI.country_id = CO.country_id
    WHERE   (CI.city, CO.country) IN (SELECT city, country FROM TopCities)
    GROUP BY C.customer_id,
            C.first_name,
            C.last_name,
            CO.country,
            CI.city
    ORDER BY SUM(P.amount) DESC
    LIMIT 5
)

SELECT  CO.country,
        COUNT(DISTINCT C.Customer_id) AS all_customer_count,
        COUNT(DISTINCT TC.customer_id) AS Top_5_customers_count
FROM    customer C
JOIN    address add ON C.address_id = add.address_id
JOIN    city CI ON add.city_id = CI.city_id
JOIN    country CO ON CI.country_id = CO.country_id
LEFT JOIN TopCustomers TC ON C.customer_id = TC.customer_id
GROUP BY CO.country
ORDER BY Top_5_customers_count DESC;
