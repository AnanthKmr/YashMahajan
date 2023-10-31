CREATE TABLE members (
 customer_id INT NOT NULL primary key,
 join_date DATE NOT NULL,
);


CREATE TABLE menu (
 product_id INT NOT NULL ,
 product_name VARCHAR(20) NOT NULL,
 price decimal(10,2) Not Null
 PRIMARY KEY (product_id)
);

CREATE TABLE sales (
 customer_id INT NOT NULL,
 order_date DATE NOT NULL,
 product_id INT NOT NULL,
);

drop table sales


INSERT INTO members (customer_id, join_date) VALUES 
(1, '2023-10-30'),
(2, '2023-10-31'),
(3, '2023-11-01');


-- Inserting into menu table
INSERT INTO menu (product_id, product_name, price) VALUES 
(1, 'P1', 10.00),
(2, 'P2', 20.00),
(3, 'P3', 15.00);

-- Inserting into sales table
INSERT INTO sales (customer_id, order_date, product_id) VALUES 
(1, '2023-10-30', 1),
(2, '2023-10-31', 2),
(3, '2023-11-01', 3);



select * from sales
go
select * from members
go
select * from menu



--What is the total amount each customer spent at the restaurant?
select 
	customer_id,sum(price) 
from sales s join menu m 
	on s.product_id=m.product_id
group by customer_id;


--How many days has each customer visited the restaurant?

with demo1 AS(
select customer_id,order_date,rank() over (order by order_date) as rnk
from sales 
)
select customer_id ,count(customer_id)as days FROM demo1
group by customer_id;
------------------------------------------------------------
INSERT INTO sales (customer_id, order_date, product_id) VALUES 
(1, '2023-11-2', 1);

go 
--What was the first item from the menu purchased by each customer
with demo2 AS(
select customer_id,product_id ,
rank() over (partition by customer_id,product_id order by order_date) as rnk
from sales )
SELECT customer_id,product_id 
from demo2 where rnk =1;

go
--What is the most purchased item on the menu and how many times was it purchased by all customers?
with demo3 as(
select top(1) product_id ,count(*) as cnt
from sales
group by product_id
order by cnt desc)
select product_name ,cnt from demo3 d join menu m on d.product_id=m.product_id

go
--Which item was the most popular for each customer?


with demo4 as(
select customer_id,product_name,count(product_name) cnt,
dense_rank() over (partition by customer_id 
		order by count(s.product_id) desc) as rank1
from sales s join menu p on s.product_id=p.product_id
group by customer_id,product_name)
select * from demo4 where rank1=1

go
insert into sales values(1,'2023-11-03',2)

go

--If each $1 spent equates to 10 points and p2 has a 2x points multiplier - how many points would each customer have?

select customer_id,
sum(case when s.product_id=1 then price*1
	Else price*20
	end) as total
from sales s join menu m 
on s.product_id=m.product_id
group by customer_id

go

select * from sales
go
select * from members
go
select * from menu



--___________________________________________________________________________________________________________________________________________________________
--DATA CLEANING______________________
--____________________________________________________________________________________________________________________________________________________________


CREATE TABLE orders (
 order_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
 customer_id INT ,
 pizza_id INT ,
 exclusions VARCHAR(20) ,
 extras VARCHAR(20),
);


insert into orders(customer_id,pizza_id) values (1,1)
insert into orders(customer_id,pizza_id) values (1,1)
insert into orders(customer_id,pizza_id) values (1,1)
insert into orders(customer_id,pizza_id) values (1,1)
insert into orders(customer_id,pizza_id, exclusions,extras) values (1,1,'yes','yes')

select * from orders


SELECT 
    order_id,
    customer_id,
    pizza_id,
    CASE
        WHEN exclusions is NULL THEN 'isnull'
        ELSE exclusions
    END as exclusions,
    CASE
        WHEN extras is NULL THEN 'isnull'
        ELSE extras
    END as extras   
INTO #cleaned_customer_orders
FROM orders;


select * from #cleaned_customer_orders
drop table #cleaned_customer_orders


--___________________________________________________________________________________________________________________



CREATE TABLE runners (
  runner_id INTEGER,
  registration_date DATE
);

INSERT INTO runners
  (runner_id, registration_date)
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');

DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  order_id INTEGER,
  customer_id INTEGER,
  pizza_id INTEGER,
  exclusions VARCHAR(4),
  extras VARCHAR(4),
  order_time Datetime
);

INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES ('1', '101', '1', '', '', '2020-01-01T18:05:02');

INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES ('2', '101', '1', '', '', '2020-01-01T19:00:52');

INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES ('3', '102', '1', '', '', '2020-01-02T23:51:23');

INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES ('3', '102', '2', '', NULL, '2020-01-02T23:51:23');

INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES ('4', '103', '1', '4', '', '2020-01-04T13:23:46');

INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES ('4', '103', '1', '4', '', '2020-01-04T13:23:46');

INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES ('4', '103', '2', '4', '', '2020-01-04T13:23:46');

INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES ('5', '104', '1', NULL , '1', '2020-01-08T21:00:29');

INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES ('6', '101', '2', NULL , NULL , '2020-01-08T21:03:13');

INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time)
VALUES ('7', '105', '2', NULL , '1' , '2020-01-08T21:20:29');

INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions,
extras , order_time)
VALUES ('8' , 102 , 1 , NULL , NULL , '2020 - 01 - 09 T23 : 54 : 33' );

INSERT INTO customer_orders (order_id , customer_id , pizza_id , exclusions ,
extras , order_time )
VALUES ('9' , 103 , 1 , 4 , 1.5 , '2020 - 01 - 10 T11 : 22 : 59' );

INSERT INTO customer_orders (order_id , customer_id , pizza_id , exclusions ,
extras , order_time )
VALUES ('10' , 104 , 1 , NULL , NULL , '2020 - 01 - 11 T18 : 34 : 49');


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  order_id INTEGER,
  runner_id INTEGER,
  pickup_time VARCHAR(19),
  distance VARCHAR(7),
  duration VARCHAR(10),
  cancellation VARCHAR(23)
);

INSERT INTO runner_orders
  (order_id, runner_id, pickup_time, distance, duration, cancellation)
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');

DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  pizza_id INTEGER,
  pizza_name TEXT
);

INSERT INTO pizza_names
  (pizza_id, pizza_name)
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');

DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  pizza_id INTEGER,
  toppings TEXT
);

INSERT INTO pizza_recipes
  (pizza_id, toppings)
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');

DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  topping_id INTEGER,
  topping_name TEXT
);

INSERT INTO pizza_toppings
  (topping_id, topping_name)
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');

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


select getdate() 