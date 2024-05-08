SELECT  C.customer_id,
        C.first_name,
	C.last_name,
	CO.country,
	CI.city,
	SUM(P.amount) AS Total_revenue
FROM country CO 
JOIN city CI ON CO.country_id = CI.country_id
JOIN address AD ON CI.city_id = AD.city_id
JOIN customer C ON AD.address_id = C.address_id
JOIN payment P ON C.customer_id = P.customer_id
GROUP BY C.customer_id,
	 C.first_name,
	 C.last_name,
	 CO.country,
	 CI.city
ORDER BY Total_revenue DESC
 
