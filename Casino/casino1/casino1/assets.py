# from dagster import AssetKey, Asset, io_manager, resource
 
# airbyte_resource = resource.configured(
#     {
#         "host": "10.100.131.125",
#         "port": "8000",
#         "username": "airbyte",
#         "password": "password"
#     }
# )
 
# @asset(
#     name="newsapi_to_snowflake_job",
#     key=AssetKey("news_api", "news_everything"),
#     io_manager=io_manager.FilesystemIOManager(path="D:\Casino\casino1\casino1"),
#     resource=airbyte_resource
# )
# def selected_asset():
#     # Load data from the selected asset
 
#     # Retrieve the asset data
#     asset_data = io_manager.get_input(context=dagster.AssetContext(asset_key=key))
 
#     # Process and analyze the asset data
#     # ...
 
#     return asset_data

from dagster import *
from typing import List 


@asset (group_name = "start_assets")
def first_asset(context : AssetExecutionContext):
    """ 
    my first asset
    """
    print("print message")
    context.log.info("first log message")
    return [1, 2, 3]
 
@asset (ins = {"upstream" : AssetIn (key = "first_asset")}, group_name = "start_assets")
def second_asset(context: AssetExecutionContext, upstream: List ):
    """
    my second asset
    """    
    data =upstream + [4, 5, 6]
    context.log.info(f"output data is: {data}")
    return data


@asset (ins={
    "first_upstream": AssetIn ("first_asset"),
    "second_upstream": AssetIn ("second_asset")
},group_name = "end_assets") 
def third_asset(
    context : AssetExecutionContext ,
    first_upstream : List ,
    second_upstream : List):
    """
    my third asset
    """    
    data = {
        "first_asset": first_upstream,
        "second_asset": second_upstream,
        "third_asset": second_upstream + [7 , 8]
    }
    context.log.info(f"output data is : {data}")
    return data