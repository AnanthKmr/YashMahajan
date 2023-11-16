{{ 
    config(
        materialized ='table'
    )
}}

with firsttable as(
select 
    * 
    from 
    {{ref ('target_merge')}} 
where 
    (select count(emp_id) from {{ref ('stream')}}) > 2
),
secondtable as(
select 
    * 
    from 
    {{ref ('target_append')}} 
where 
    (select count(emp_id) from {{ref ('stream')}}) <= 2
),

 

union_tables as(  
select
    * 
    from
    firsttable 
 union all 
select 
    * 
    from
    secondtable  )

select 
    t.* 
  FROM {{ this }} t
  left join
  union_tables  u  
  on t.emp_id = u.emp_id 


      