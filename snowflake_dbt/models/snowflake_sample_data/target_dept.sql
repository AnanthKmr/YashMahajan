



{{
    config(
        materialized='incremental',
        unique_key='empid',
        incremental_strategy='merge'
    )
}}


WITH

using_clause AS (
 
 
    SELECT
       deptid,
       deptname,
       empid,
       empname,
       sal,
       current_timestamp() as src_updated_datetime
    FROM {{ ref('join')}}
   
    {% if is_incremental() %}
 
 
        WHERE src_updated_datetime > (SELECT ifnull(max(src_updated_datetime),'1900-01-01'::TIMESTAMP) FROM {{ this }})
 
 
    {% endif %}
 
 
),
  
updates AS (
 
 
 
    SELECT
       deptid,
       deptname,
       empid,
       empname,
       sal,
       current_timestamp() as src_updated_datetime
    from using_clause
 
 
 
    {% if is_incremental() %}
 
 
 
        WHERE empid IN (SELECT empid FROM {{ this }})
 
 
 
    {% endif %}
 
 
 
),
 
 
 
inserts AS (
 
    SELECT
       deptid,
       deptname,
       empid,
       empname,
       sal,
        current_timestamp() as src_updated_datetime
    from using_clause
 
 
    WHERE empid NOT IN (SELECT empid FROM updates) 
)

 
SELECT * FROM updates UNION SELECT * FROM inserts