
{{ config(
   materialized ='table', 
   post_hook="insert into {{ this }} values(19,'sushrut',888,CURRENT_TIMESTAMP)"
) }}


select * from postgres.emp