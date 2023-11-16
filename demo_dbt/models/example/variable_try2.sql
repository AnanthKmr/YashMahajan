{{
    config(
        materialized ='table'
 )
}}


{% set sources = ["str_merge","src_emp"] %}


with loops as (
{% for source in sources %}
    select * 
    from 
    {{ref (source)}}

    {% if not loop.last %}

    union all
    
    {% endif %}
{% endfor %}
)
select * from loops