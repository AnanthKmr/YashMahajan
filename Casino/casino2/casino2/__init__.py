from dagster import Definitions, load_assets_from_modules

from . import assets
from . import my_assets
from . import new_assets

all_assets = load_assets_from_modules([assets_2,new_assets,my_assets])


defs = Definitions(
    assets=all_assets,
)
