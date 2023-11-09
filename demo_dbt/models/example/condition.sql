{{
    config(
        materialized ='table'
    )
}}

select * from postgres.emp 
where row_count > 10