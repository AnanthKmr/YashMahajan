
{{ config(materialized='table') }}


with cte as(
    select * from postgres.sales where order_id =1 or order_id =2
)

select * from cte 