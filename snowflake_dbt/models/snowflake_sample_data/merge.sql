

{{ config(
   materialized='table'
) }}

with source1 as (
   select *
   from {{ ref ('src_std') }}
),
source2 as (
   select *
   from {{ ref ('src_teach') }}
)
select *
from source1
union all
select *
from source2