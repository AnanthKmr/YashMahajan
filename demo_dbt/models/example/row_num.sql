{{
    config(
        materialized ='table'
    )
}}


select *,
    row_number() over (order by emp_id ) as rnum 
from postgres.emp    