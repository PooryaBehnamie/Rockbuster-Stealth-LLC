SELECT  F.title,
	F.rating,
	SUM(P.amount) AS Total_revenue		
FROM film F
JOIN inventory Inv ON F.film_id = Inv.film_id
JOIN rental R ON Inv.inventory_id = R.inventory_id
JOIN payment P ON R.rental_id = P.rental_id
GROUP BY F.title,
	 F.rating
ORDER BY Total_revenue DESC
