SELECT   CO.country,
	 CI.city,
	 F.rating,
	 CA.name AS Category,
	 SUM(P.amount) AS Total_revenue,
	 COUNT(R.rental_id) AS Rental_count
FROM film F
JOIN language L ON F.language_id = L.language_id
JOIN film_category FM ON F.film_id = FM.film_id
JOIN category CA ON FM.category_id = CA.category_id
JOIN inventory Inv ON F.film_id = Inv.film_id
JOIN rental R ON Inv.inventory_id = R.inventory_id
JOIN payment P ON R.rental_id = P.rental_id
JOIN customer C ON P.customer_id = C.customer_id
JOIN address AD ON C.address_id = AD.address_id
JOIN city CI ON AD.city_id = CI.city_id
JOIN country CO ON CI.country_id = CO.country_id
GROUP BY  CO.country,
	  CI.city,
	  F.rating,
	  CA.name
ORDER BY  Total_revenue DESC, 
	  Rental_count DESC
 
