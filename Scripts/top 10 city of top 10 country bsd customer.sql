SELECT  
		CI.city,
		CO.country,
		COUNT(DISTINCT C.customer_id) AS Customer_count,
		SUM(P.amount) AS Total_revenue
FROM country CO 
JOIN city CI ON CO.country_id = CI.country_id
JOIN address AD ON CI.city_id = AD.city_id
JOIN customer C ON AD.address_id = C.address_id
JOIN payment P ON C.customer_id = P.customer_id
WHERE CO.country IN (SELECT CO.country
					 FROM country CO 
					 JOIN city CI ON CO.country_id = CI.country_id
					 JOIN address AD ON CI.city_id = AD.city_id
					 JOIN customer C ON AD.address_id = C.address_id
					 GROUP BY CO.country
					 ORDER BY COUNT(DISTINCT customer_id) DESC
					 LIMIT 10)
GROUP BY CO.country, CI.city
ORDER BY Customer_count DESC, Total_revenue DESC
LIMIT 10

