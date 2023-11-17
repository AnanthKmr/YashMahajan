
{{
    config(
        materialized='incremental',
        
        incremental_strategy='merge'
    )
}}

WITH
 
using_clause AS (
 
 
 
    SELECT
        emp_id,
        emp_name,
        sal,
        current_timestamp as src_updated_datetime
    FROM {{ ref ('stream')}}
   
 
 
 
 
    {% if is_incremental() %}
 
 
        WHERE (select count(emp_id) from {{ref ('stream')}}) <= 2
 
 
 
    {% endif %}
 
 
 
),
 
 
 
updates AS (
 
 
 
    SELECT
        emp_id,
        emp_name,
        sal,
        current_timestamp as src_updated_datetime
    FROM using_clause
 
 
 
    {% if is_incremental() %}
 
 
 
        WHERE emp_id IN (SELECT emp_id FROM {{ this }})
 
 
 
    {% endif %}
 
 
 
),
 
 
 
inserts AS (
 
 
 
    SELECT
        emp_id,
        emp_name,
        sal,
        current_timestamp as src_updated_datetime
    FROM using_clause
 
 
 
    WHERE emp_id NOT IN (SELECT emp_id FROM updates)
 
 
 
)
 
 
 
SELECT * FROM updates UNION SELECT * FROM inserts