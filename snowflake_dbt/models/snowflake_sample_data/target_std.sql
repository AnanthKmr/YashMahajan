




{{
    config(
        materialized='incremental',
        unique_key='teacherid',
        incremental_strategy='merge'
    )
}}


WITH

using_clause AS (
 
 
    SELECT
       stdid,
       stdname,
       marks,
       TEACHERID,
       TEACHERNAME,
       current_timestamp() as src_updated_datetime
    FROM {{ ref('merge1')}}
   
    {% if is_incremental() %}
 
 
        WHERE src_updated_datetime > (SELECT ifnull(max(src_updated_datetime),'1900-01-01'::TIMESTAMP) FROM {{ this }})
 
 
    {% endif %}
 
 
),
  
updates AS (
 
 
 
    SELECT
       stdid,
       stdname,
       marks,
       TEACHERID,
       TEACHERNAME,
       current_timestamp() as src_updated_datetime
    from using_clause
 
 
 
    {% if is_incremental() %}
 
 
 
        WHERE stdid IN (SELECT stdid FROM {{ this }})
 
 
 
    {% endif %}
 
 
 
),
 
 
 
inserts AS (
 
    SELECT
       stdid,
       stdname,
       marks,
       TEACHERID,
       TEACHERNAME,
       current_timestamp() as src_updated_datetime
    from using_clause
 
 
    WHERE stdid NOT IN (SELECT stdid FROM updates) 
)

 
SELECT * FROM updates UNION SELECT * FROM inserts