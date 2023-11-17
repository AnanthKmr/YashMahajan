
{{ 
    config(
        materialized ='table'
    )
}}

 
with
union_tables as(  
select
    * 
    from
    {{ref ('target_append1')}}
    
 union 
select 
    * 
    from
    {{ref ('target_merge1')}} 
    ),


unionfirsttable as(
select 
    * 
    from 
    union_tables
where 
    (select count(emp_id) from {{ this }}) = 0
),
unionsecondtable as(
select 
    t.* 
    from 
    {{ this }} t
    join 
    union_tables u 
    on 
    t.emp_id = u.emp_id 
    or t.emp_id <> u.emp_id
    
)

select
    * 
    from
    unionfirsttable 
    
 union all 
select 
    * 
    from
    unionsecondtable







      