from dagster import *
from typing import List 


@asset (group_name = "mid_assets")
def my_asset(context : AssetExecutionContext):
    """ 
    my first asset
    """
    print("print message")
    context.log.info("first log message")
    return [1, 2, 3]
 