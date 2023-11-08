{{ config(materialized='table') }} 

with std as (
    select * from postgres.student
)

select * from std