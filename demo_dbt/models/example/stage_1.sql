
{{ config(materialized='table') }} 
with stage1 as (
    select * 
    from {{ref ('random')}}
)

select * from stage1