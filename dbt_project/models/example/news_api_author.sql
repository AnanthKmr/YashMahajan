{{ config(materialized='table') }}


WITH raw_news AS (
  SELECT
    PUBLISHEDAT,
    AUTHOR,
    SOURCE,
    TITLE,
    URL
  FROM
    {{ ref('news_api') }}
),
 

transformed_news AS (
  SELECT
    PUBLISHEDAT,
    AUTHOR,
    SOURCE,
    TITLE,
    URL,
  
    UPPER(AUTHOR) as uppercased_author,
   
    LEFT(TITLE, 30) as short_title,
   
    TO_DATE(PUBLISHEDAT) as publish_date,
    
    TO_TIME(PUBLISHEDAT) as publish_time,
    
    REPLACE(LOWER(TITLE), ' ', '-') as title_slug
   
  FROM
    raw_news
)
 

SELECT
  
  
  SOURCE,
  TITLE,
  URL,
  uppercased_author,
  short_title,
  publish_date,
  publish_time,
  title_slug
FROM
  transformed_news