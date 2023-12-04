
##-------------------------------------------------------------------------
#airbyte.py
 
 
 
# from dagster_airbyte import  AirbyteResource, load_assets_from_airbyte_instance
# from scipy import optimize
 
# # from .constants import AIRBYTE_CONFIG
 
# airbyte_instance = AirbyteResource(
#    host="10.100.131.125",
#    port="8000",
#    # If using basic auth, include username and password:
#    username="airbyte",
#    password="password",
# )
# airbyte_assets = load_assets_from_airbyte_instance( airbyte_instance,key_prefix=('student_s'))

from dagster import job, repository, Definitions, op, OpExecutionContext, asset, define_asset_job,AssetSelection
from dagster_airbyte import airbyte_resource, airbyte_sync_op, build_airbyte_assets, load_assets_from_airbyte_instance
import json
import pandas as pd

airbyte_instance = airbyte_resource.configured(
    {
        "host": "10.100.131.125",
        "port": "8000",
        "username": "airbyte",
        "password": "password"
    }
)


newsapi_to_snowflake_job = airbyte_sync_op.configured(
    {"connection_id": "ebde3bd0-dfc7-4fb9-9de8-12219785a703"}, name="newsapi_to_snowflake_job"
)

@op
def logger(context: OpExecutionContext, input_state):
   #  status = input_state.job_details['attempts'][0]['attempt']['status']
   #  recordsSynced = input_state.job_details['attempts'][0]['attempt']['recordsSynced']
   #  context.log.info(f"Job Status {status} and Number of records synced are {recordsSynced}.")
    context.log.info(input_state)

@job(resource_defs={"airbyte": airbyte_instance})
def airbyte_newsapi_to_snowflake_job():
    state = [newsapi_to_snowflake_job()]
    logger(state)


airbyte_assets = load_assets_from_airbyte_instance(airbyte_instance,key_prefix=('snowflake_news_api'))
