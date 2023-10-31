select * from pizza_toppings
go
select * from pizza_recipes
go
select * from pizza_names
go
select * from runner_orders
go
select * from customer_orders
go
select * from runners



--How many pizzas were ordered?
select count(pizza_id) total
from customer_orders



--How many unique customer orders were made?
select count(distinct(customer_id))
from customer_orders



--How many successful orders were delivered by each runner

select runner_id,count(runner_id) total
from runner_orders
where 
	pickup_time <> 'null'
group by runner_id


--How many of each type of pizza was delivered
select p.pizza_name,count(c.pizza_id) as total
from customer_orders c
join pizza_names p
	on c.pizza_id=p.pizza_id
join runner_orders r 
	ON c.order_id=r.order_id
	where cancellation is null or cancellation = 'null'

group by p.pizza_name



--How many Vegetarian and Meatlovers were ordered by each customer

SELECT customer_id,pizza_name,
	COUNT(c.order_id) as total
FROM customer_orders c 
	join pizza_names p
on c.pizza_id = p.pizza_id
GROUP BY 
customer_id,pizza_name
ORDER BY 
customer_id;


--What was the maximum number of pizzas delivered in a single order

SELECT TOP(1) c.order_id,
	count(pizza_id) as total
FROM customer_orders c join
	runner_orders r
on c.order_id = r.order_id
	where r.cancellation is null
GROUP BY c.order_id
ORDER BY 
total DESC;





