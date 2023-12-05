import pandas as pd
df = pd. read_parquet('taxi_trips_2023-03', engine='pyarrow')
print(df)
