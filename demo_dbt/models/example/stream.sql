
{{
    config(
        materialized='table'
         
    )
}}

WITH
 
stream1 AS (
 
 
 
    SELECT
        emp_id,
        emp_name,
        sal,
        src_updated_datetime
    FROM {{ ref ('src_emp')}}
   
 
 
 
 
    
     
 
        WHERE src_updated_datetime > (SELECT COALESCE(max(src_updated_datetime),'1900-01-01'::TIMESTAMP) FROM {{ this }})
 

   
 
 
 
)

select * from stream1