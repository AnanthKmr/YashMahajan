

with selected as(
    select empid,empname,
    ROW_NUMBER() OVER (order by empid)  as rnk  
    from 
    {{ref('source_insert1')}}

)

select max(rnk)  from selected