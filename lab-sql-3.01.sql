
-- Drop column picture from staff.
ALTER TABLE staff
DROP picture;

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
-- Update the database accordingly.

INSERT INTO STAFF (first_name, last_name, email, address_id, store_ID, username,password)
SELECT c.first_name, c.last_name,c.EMAIL,c.address_id,jon.store_ID,c.first_name as username, concat(left(c.first_name,1),c.last_name) as 'password' FROM CUSTOMER c
CROSS JOIN (select store_ID from staff where first_name='Jon') jon
WHERE c.first_name="Tammy" and c.last_name="Sanders";


INSERT INTO rental (rental_date,inventory_id,customer_id,staff_id)
SELECT curdate() AS rental_date, t.inventory_id, c.customer_id, s.staff_id FROM customer c
CROSS JOIN (select min(inventory_id) as inventory_id 
	FROM inventory i 
    JOIN film f 
    ON i.film_id=f.film_id 
    JOIN store s 
    ON i.store_id=s.store_id
 WHERE f.title="Academy Dinosaur" AND s.store_id=1) t
CROSS JOIN (select staff_id from staff where first_name='Mike' and last_name='Hillyer') s
WHERE c.first_name='Charlotte' and c.last_name='Hunter';



