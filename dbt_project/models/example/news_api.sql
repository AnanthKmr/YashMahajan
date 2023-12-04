{{ config(materialized='table') }}

with news as(
    select * from {{ source ("snowflake_news_api" , "everything")}}
)

select 
    PUBLISHEDAT,
	AUTHOR ,
	SOURCE ,
	TITLE ,
	URL
from news    