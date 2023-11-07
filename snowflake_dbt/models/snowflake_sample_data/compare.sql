
with source1 as (
   select *
   from {{ ref ('src_std') }}
),
source2 as (
   select *
   from {{ ref ('src_teach') }}
),
source1_row_count as (
   select count(*) as row_count
   from source1
),
source2_row_count as (
   select count(*) as row_count
   from source2
)
select *
from (
   select *, 'source1' as sr1
   from source1
   union all
   select *, 'source2' as sr1
   from source2
) as combined_sources
where combined_sources.row_count = (
   select max(row_count)
   from source1_row_count, source2_row_count
   where row_count is not null
)