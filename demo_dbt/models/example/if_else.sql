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
        insert into postgres.emp values(17,'k234k',000009,CURRENT_TIMESTAMP);
{% else %}
       insert into postgres.emp values(17,'k234k',000009,CURRENT_TIMESTAMP);
{% endif %}