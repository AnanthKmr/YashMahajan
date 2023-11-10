{% set football_clubs = ['lazio', 'borrusia dortmund', 'olympique lyonnais', 'valencia', 'manchester united'] %}

-- {{ print(football_clubs[0]) }}


{% for source in football_clubs %}
    select all from {{1 + 1}}
    union all

{% endfor %}