import snowflake.snowpark.functions as F


def model(dbt, session):
    dbt.config(materialized = "table")
    
    stg_emp= dbt.ref("src_emp")

    
    int_emp = stg_emp.drop_duplicates(
      
    )
    

    return int_emp