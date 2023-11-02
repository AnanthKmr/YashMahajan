

with macro as(
    select 
    *
    from {{ref ('source_insert1')}}
    where {{count1('source_insert1')}} >= 2  
)


select * from macro

  