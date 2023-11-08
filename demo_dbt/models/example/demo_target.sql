
{{ config(materialized='table') }}

with demo as (
    select 
    emp_id,emp_name from 
    {{ref ('src_emp')}}
)

select * from demo