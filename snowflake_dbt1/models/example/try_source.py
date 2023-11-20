import snowflake.snowpark.functions as F

def model(dbt, session):
    dbt.config(materialized = "table")

    source_df = dbt.source("student_s", "bank_stream")
    target_name = dbt.source("student_s", "target_dp")
    

    ans='true'

    if ans=='true':
        result=source_df.describe()

    return result

