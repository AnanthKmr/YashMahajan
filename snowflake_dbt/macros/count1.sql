

{% macro count1(stream) %}
    {% set query %}

        select 
        count(*)
        from {{stream}}

    {% endset %} 

    {% set results = run_query (query) %}
    {% if execute %}
        {% set result1 = results.columns[0].values()[0] %}
    {% endif %}
    {{return (result1)}}

{% endmacro %}      