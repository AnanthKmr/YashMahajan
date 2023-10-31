
{{ config(materialized='table') }}


with cte as(
    select * from sales where order_id =1 or order_id =2
)

select * from cte 
where order_id