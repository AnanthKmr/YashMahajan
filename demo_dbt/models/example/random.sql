{{ config(materialized='table') }} 


SELECT
    s as id,
     floor(random() * 100 + 1)::int as random_integer,
    md5(random()::text) as random_string
FROM generate_series(1,100) s
