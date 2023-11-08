

{{ config(materialized='table') }} 

with check1 as (
    select * from postgres.emp
)

select * from check1