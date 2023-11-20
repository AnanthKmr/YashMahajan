import snowflake.snowpark.functions as F

def model(dbt, session):
    dbt.schema(materialized = "table")

    target_name = dbt.source("student_s", "target_dp")

    source_df = dbt.source("student_s", "bank_stream")
    
    if source_df.count() <= 2:
        insert_query = f"insert into {target_name} select * from {source_df}"
        result=session.sql(insert_query)
        
    else:
        updt_fields={}
        trgt_cols = target_name.columns
        for col_name in trgt_cols:
            if col_name in source_df.columns:
                updt_fields[col_name] = source_df[col_name]
        result=target_name.merge(source_df, (target_name["custid"] == source_df["custid"]),
                    [when_matched().update(updt_fields), when_not_matched().insert(updt_fields)])

    result.show()

    return result