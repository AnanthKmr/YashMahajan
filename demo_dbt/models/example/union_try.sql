with union_tables as(  
select
    * 
    from
    {{ref ( 'target_append' ) }} 
 union all 
select 
    * 
    from
    {{ref ( 'target_merge' ) }}   )

select * from union_tables    