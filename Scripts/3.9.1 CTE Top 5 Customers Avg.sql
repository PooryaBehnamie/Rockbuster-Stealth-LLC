WITH CTE_Top5_customers (customer_id, First_name, Last_name, Country, City, Total_Amount)
AS (SELECT	C.customer_id,
					C.first_name,
					C.last_name,
        			CO.country,
        			CI.city,
					SUM(P.amount) AS Total_Amount
		 	FROM	payment P
		 	INNER JOIN customer C ON P.customer_id = C.customer_id
         	INNER JOIN address add ON C.address_id = add.address_id
         	INNER JOIN city CI ON add.city_id = CI.city_id
         	INNER JOIN country CO ON CI.country_id = CO.country_id
		 	WHERE CI.city IN  ( SELECT	CI.city
								FROM customer C
								INNER JOIN address add ON C.address_id = add.address_id
       			    			INNER JOIN city CI ON add.city_id = CI.city_id
        						INNER JOIN country CO ON CI.country_id = CO.country_id
      							WHERE country IN   (SELECT	CO.country
													FROM customer C
													INNER JOIN address add ON C.address_id = add.address_id
       			   									INNER JOIN city CI ON add.city_id = CI.city_id
        											INNER JOIN country CO ON CI.country_id = CO.country_id
													GROUP BY CO.country
													ORDER BY COUNT(C.customer_id) DESC
													LIMIT 10)
								GROUP BY CI.city, CO.country
								ORDER BY COUNT(C.customer_id) DESC
								LIMIT 10)	
			GROUP BY C.customer_id,
		 		 	 C.first_name,
		 		 	 C.last_name,
         		 	 CO.country,
         		 	 CI.city
			ORDER BY
        			 SUM(P.amount) DESC
			LIMIT 5)
SELECT AVG(Total_Amount)
FROM CTE_Top5_customers