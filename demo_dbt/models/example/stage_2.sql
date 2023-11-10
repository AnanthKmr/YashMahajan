


{{ config(materialized='table') }} 

with stage2 as (
    select * 
    from {{ref ('random')}}
)

select * from stage2