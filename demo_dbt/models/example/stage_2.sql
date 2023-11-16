

{{
    config(
        materialized='incremental',
        unique_key='emp_id',
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
    FROM postgres.emp
   
 
 
 
 
    {% if is_incremental() %}
 
 
        WHERE src_updated_datetime > (SELECT COALESCE(max(src_updated_datetime),'1900-01-01'::TIMESTAMP) FROM {{ this }})
 
 
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