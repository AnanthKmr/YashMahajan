import sys

from dagster import Definitions, load_assets_from_modules

from . import assets
sys.path.insert(2,"D:\\Casino\\casino2\\casino2")

import my_assets
import new_assets


all_assets = load_assets_from_modules([assets,my_assets,new_assets])

defs = Definitions(
    assets=all_assets,
)
