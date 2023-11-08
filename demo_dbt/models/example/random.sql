{{ config(materialized='table') }} 

WITH random_data AS (
    SELECT
        i AS id

    FROM generate_series(1, 100) AS s(i)
)

SELECT * FROM random_data

