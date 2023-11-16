[17:39] Yash Mahajan
-- Create a dbt model to conditionally select data from tables

{{ config(

    materialized='table'

) }}

-- Count the rows in the first table

with first_table_count as (

    select count(*) as row_count

    from postgres.emp

),

-- Count the rows in the second table

second_table_count as (

    select count(*) as row_count

    from second_table

)

select *

from (

    select * from first_table

    union all

    select * from second_table

) as combined_data

where

    (select row_count from first_table_count) > 10  -- Use the first table if it has more than 10 rows

    or

    (select row_count from second_table_count) <= 10;  -- Use the second table if the first table has 10 rows or fewer