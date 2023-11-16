

{{ config(
 materialized='table'
) }}

--depends_on: {{ref ('src_emp')}},{{ref ('str_merge')}}


with src_emp_count as (
 select count(*) as emp_count
 from {{ ref('src_emp') }}
)

select
 *,
 case
   when (select emp_count from src_emp_count) = 1 then select * from {{ ref('str_merge') }}
   else {{ ref('src_emp') }}
 end as accounts