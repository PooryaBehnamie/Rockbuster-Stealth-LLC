SELECT	cty.city,
        cntry.country,
	COUNT(C.customer_id) AS "Number of Customers"
FROM customer C
INNER JOIN address add ON C.address_id = add.address_id
INNER JOIN city cty ON add.city_id = cty.city_id
INNER JOIN country cntry ON cty.country_id = cntry.country_id
WHERE country IN   (SELECT cntry.country
		    FROM customer C
		    INNER JOIN address add ON C.address_id = add.address_id
       		    INNER JOIN city cty ON add.city_id = cty.city_id
        	    INNER JOIN country cntry ON cty.country_id = cntry.country_id
		    GROUP BY cntry.country
		    ORDER BY COUNT(C.customer_id) DESC
		    LIMIT 10)
GROUP BY cty.city, cntry.country
ORDER BY COUNT(C.customer_id) DESC
LIMIT 10
					
