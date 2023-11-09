{{ config(
   materialized='table'
) }}

--depends_on: {{ref ('src_emp')}},{{ref ('str_merge')}}

with src_emp_count as (
   select count(*) as emp_count
   from {{ ref('src_emp') }}
)
select
   *
from
{% if emp_count == 8 %}
   {{ ref('src_merge') }}    accounts
{% else %}
       {{ ref('src_emp') }}   accounts
{% endif %}