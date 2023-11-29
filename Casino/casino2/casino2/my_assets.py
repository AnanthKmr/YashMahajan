from dagster import *
from typing import List 


@asset (group_name = "start_assets")
def my_first_asset(context : AssetExecutionContext):
    """ 
    my first asset
    """
    print("print message")
    context.log.info("first log message")
    return [1, 2, 3]
 
@asset (ins = {"upstream" : AssetIn (key = "my_first_asset")}, group_name = "start_assets")
def my_second_asset(context: AssetExecutionContext, upstream: List ):
    """
    my second asset
    """    
    data =upstream + [4, 5, 6]
    context.log.info(f"output data is: {data}")
    return data


@asset (ins={
    "first_upstream": AssetIn ("my_first_asset"),
    "second_upstream": AssetIn ("my_second_asset")
},group_name = "end_assets") 
def my_third_asset(
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