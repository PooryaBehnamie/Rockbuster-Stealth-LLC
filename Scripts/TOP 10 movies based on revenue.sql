SELECT   F.title,
	 F.rating,
	 C.name AS Category,
	 SUM(P.amount) AS Total_revenue,
	 COUNT(R.rental_id) AS Rental_count,
	 F.rental_rate,
	 F.rental_duration,
	 F.length,
	 F.replacement_cost	
FROM film F
JOIN film_category FM ON F.film_id = FM.film_id
JOIN category C ON FM.category_id = C.category_id
JOIN inventory Inv ON F.film_id = Inv.film_id
JOIN rental R ON Inv.inventory_id = R.inventory_id
JOIN payment P ON R.rental_id = P.rental_id
GROUP BY  F.title,
	  F.rating,
	  C.name,
	  F.rental_rate,
	  F.rental_duration,
	  F.length,
	  F.replacement_cost
ORDER BY Total_revenue DESC, 
	 Rental_count DESC
