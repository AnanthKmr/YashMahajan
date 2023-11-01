


{{
    config(
        materialized='incremental',
        incremental_strategy='append'
    )
}}


WITH

using_clause AS (
 
 
    SELECT
        CUSTOMER_ID,
	    ORDER_ID,
	    PRODUCT_ID,
        current_timestamp() as src_updated_datetime
    FROM {{ ref('source_sales')}}
   
    {% if is_incremental() %}
 
 
        WHERE src_updated_datetime > (SELECT ifnull(max(src_updated_datetime),'1900-01-01'::TIMESTAMP) FROM {{ this }})
 
 
    {% endif %}
 
 
 
),
 
 
 
updates AS (
 
 
 
    SELECT
        CUSTOMER_ID,
	    ORDER_ID,
	    PRODUCT_ID,
        current_timestamp() as src_updated_datetime
    from using_clause
 
 
 
    {% if is_incremental() %}
 
 
 
        WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM {{ this }})
 
 
 
    {% endif %}
 
 
 
),
 
 
 
inserts AS (
 
    SELECT
        CUSTOMER_ID,
	    ORDER_ID,
	    PRODUCT_ID,
        current_timestamp() as src_updated_datetime
    from using_clause
 
 
 
    WHERE CUSTOMER_ID NOT IN (SELECT CUSTOMER_ID FROM updates)
 
 
 
)
 
 
 
SELECT * FROM updates UNION SELECT * FROM inserts