SELECT   C.customer_id,
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
WHERE CI.city IN (SELECT  CI.city
		  FROM country CO 
		  JOIN city CI ON CO.country_id = CI.country_id
		  JOIN address AD ON CI.city_id = AD.city_id
		  JOIN customer C ON AD.address_id = C.address_id
		  JOIN payment P ON C.customer_id = P.customer_id
	          WHERE CO.country IN  (SELECT CO.country
			                 FROM country CO 
					 JOIN city CI ON CO.country_id = CI.country_id
					 JOIN address AD ON CI.city_id = AD.city_id
					 JOIN customer C ON AD.address_id = C.address_id
					 GROUP BY CO.country
					 ORDER BY COUNT(DISTINCT customer_id) DESC
					 LIMIT 10)
		  GROUP BY CO.country, CI.city
		  ORDER BY COUNT(DISTINCT C.customer_id) DESC, SUM(P.amount) DESC
		  LIMIT 10)
GROUP BY  C.customer_id,
	  C.first_name,
	  C.last_name,
          CO.country,
	  CI.city
ORDER BY Total_revenue DESC
LIMIT 5

