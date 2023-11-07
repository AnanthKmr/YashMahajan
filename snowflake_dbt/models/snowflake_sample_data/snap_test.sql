


with snap as (
    select 
    STDID,
    STDNAME,
    MARKS,
    DBT_SCD_ID,
    DBT_UPDATED_AT,
    DBT_VALID_FROM,
    DBT_VALID_TO,
    UPDATED_AT
    from {{ ref ('add_snapshot') }} 
    where 
    DBT_VALID_TO is null

)

select * from snap