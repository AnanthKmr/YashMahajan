from dagster import *
from dagster_dbt import DbtCliResource, dbt_assets
import sys
from .constants import dbt_manifest_path
# sys.path.insert(1,"D:\\airbyte_dbt\\airbyte_dbt_dagster\\dbt_project\\models\\example")

# import news_api_author
# import news_api

@dbt_assets(manifest=dbt_manifest_path )
def dbt_newsapi_v1_dbt_assets(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()

# @asset
# def news_api_author (news_api):
#     return news_api [[  PUBLISHEDAT,
#     AUTHOR,
#     SOURCE,
#     TITLE,
#     URL  ]]
