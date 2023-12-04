from dagster import *
import loggers
from loggers import json_console_logger

@asset
def some_asset():
    ...


the_job = define_asset_job("the_job", selection="*")


defs = Definitions(
    jobs=[the_job], assets=[some_asset], loggers={"json_logger": json_console_logger}
)