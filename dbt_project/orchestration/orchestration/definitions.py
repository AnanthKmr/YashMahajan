# import os

# from dagster import Definitions
# from dagster_dbt import DbtCliResource

# from .dbt import snowflake_dbt1_dbt_assets
# from .airbyte import airbyte_assets
# from .constants import dbt_project_dir
# from .schedules import schedules

# defs = Definitions(
# #   assets=[snowflake_dbt1_dbt_assets, airbyte_assets],
#     assets=[airbyte_assets],
#     schedules=schedules,
#     # resources={
#         # "dbt": DbtCliResource(project_dir=os.fspath(dbt_project_dir)),
        
#     # },
# )

###-----------------------------------------------------------
import os
 
from dagster import Definitions
from dagster import ScheduleDefinition
from dagster import define_asset_job
from dagster_dbt import DbtCliResource
 
from .dbt import dbt_newsapi_v1_dbt_assets
from .airbyte import airbyte_assets
from .constants import dbt_project_dir


 
defs = Definitions(
    assets=[dbt_newsapi_v1_dbt_assets,airbyte_assets],
   
    resources={
        "dbt": DbtCliResource(project_dir=os.fspath(dbt_project_dir)),
    },
   
    schedules=[
 
        ScheduleDefinition(
            job=define_asset_job("all_assets",selection="*") , cron_schedule = "@daily"
        ),
    ],
)





