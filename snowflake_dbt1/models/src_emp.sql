


{{ config(materialized='table') }}


with src_emp as(
    select * from emp
)

select * from src_emp