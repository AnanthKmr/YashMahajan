{{
    config(
        materialized ='table'
 )
}}


--depends_on: {{ref ('src_emp')}},{{ref ('str_merge')}}

SELECT
*
FROM

{% if var('count1') == 'false' %}
   {{ ref('src_emp') }}    accounts
{% else %}
       {{ ref('str_merge') }}   accounts
{% endif %}