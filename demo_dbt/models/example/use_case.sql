{{ 
    config(
        materialized ='table'
    )
}}

with firsttable as(
select 
    * 
    from 
    {{ref ('stage_1')}} 
where 
    (select count(id) from {{ref ('stage_1')}}) > 1000
),
secondtable as(
select 
    * 
    from 
    {{ref ('stage_2')}} 
where 
    (select count(id) from {{ref ('stage_2')}}) > 1000
)


select 
    * 
    from
    firsttable 
    union 
select 
    * 
    from
    secondtable     
