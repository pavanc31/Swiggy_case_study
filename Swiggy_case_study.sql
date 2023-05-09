# 1. Find the customer who never ordered
-- First Method (Using Joins)

SELECT name FROM users AS u
JOIN orders AS o
ON u.user_id = o.user_id
WHERE o.user_id IS NULL;

-- Second Method ( Using Sub_Querry)

SELECT name FROM users 
WHERE user_id NOT IN (SELECT user_id FROM orders);

-- BY exexcuting this query we will find the customers who never orderd on the swiggy.


# 2. Find the average price of each dish

SELECT f_name,AVG(price) AS avg_price FROM food AS f
JOIN menu AS m
ON f.f_id = m.f_id
GROUP BY f_name;

-- BY exexcuting this query we will get the average price of the each dish.


# 3. Find the top restaurnts in terms of number of orders for a given month (june)

SELECT r_name,COUNT(*) AS max_orders FROM restaurants AS r 
JOIN orders AS o
ON r.r_id = o.r_id
WHERE MONTHNAME(date) ='june'
GROUP BY r_name
ORDER BY max_orders DESC
LIMIT 1;

-- BY exexcuting this query we will get the restaurant who got the top orders in the particular month and the restarant is KFC.

# 4. Restaurants with monthly sales greater then 1000

SELECT r_name, SUM(amount) AS revenue FROM restaurants AS r 
JOIN orders AS o
ON r.r_id = o.r_id
WHERE MONTHNAME(date) = 'july'
GROUP BY r_name
HAVING SUM(amount) > 1000;

-- By this we can conclude that 3 restaurants have the sales greater then 1000.

# 5. Show all orders with order details for a particular customer in a paricular range

SELECT u.user_id,o.order_id,r_name,f_name,date,amount FROM order_details AS od
JOIN orders AS o
ON od.order_id = o.order_id
JOIN food AS f
ON f.f_id = od.f_id
JOIN users AS u
ON o.user_id = u.user_id
JOIN restaurants AS r
ON r.r_id = o.r_id
WHERE name ='ankit' AND date > '2022-06-10' AND date <'2022-07-10';

-- on executing this Query we can find the details of the particular customer in a certain range of date

# 6. Find the restauraunts with max repeated customers

SELECT r_id,r_name, COUNT(*) AS loyal_customers
FROM
     (
		SELECT  r_name,o.r_id,user_id , COUNT(*) AS visits FROM orders AS o
        JOIN restaurants as r
        on o.r_id = r.r_id
		GROUP BY user_id , r_id,r_name
		HAVING visits > 1
        )  AS t
        GROUP BY r_id,r_name
		ORDER BY LOYAL_CUSTOMERS DESC 
        LIMIT 1;
        
-- We can say KFC has a most repeated or loyal customers by this query
        
# 7. Month over month growth of swiggy

SELECT month,((revenue - prev)/prev)*100 AS per_revenue FROM
(
WITH sales AS
(
SELECT monthname(date)AS month,sum(amount)AS revenue FROM orders
GROUP BY month
)
SELECT month,revenue,LAG(revenue,1) OVER(ORDER BY revenue) AS prev FROM sales) AS table1

-- This shows the month over month revenue of the swiggy


