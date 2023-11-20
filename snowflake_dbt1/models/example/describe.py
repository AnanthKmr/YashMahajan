import snowflake.snowpark.functions as F


def model(dbt, session):
    dbt.config(materialized = "table")

    source_df = dbt.source("student_s", "bank_stream")

    info=dbt.ref("src_emp").describe()

    infoc=info.collect()

    result=infoc[1][1]

    if result == 2:
        info.rename(F.col('SUMMARY'),'summary1')
    else:
        info.rename(F.col('SUMMARY'),'summary1')    
   
    return info 

    



