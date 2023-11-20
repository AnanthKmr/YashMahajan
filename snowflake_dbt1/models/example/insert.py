import snowflake.snowpark.functions as F

def model(dbt, session):
    dbt.config(materialized = "table")

    table='emp'

    insert_query = f"insert into {table} values (7,'adad',6666);"
    result=session.sql(insert_query)



    

    return result

