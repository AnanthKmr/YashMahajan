{{
    config(
        materialized ='table'
    )
}}


select 
    max(rnum) maxnum 
from {{ref ('row_num')}}   