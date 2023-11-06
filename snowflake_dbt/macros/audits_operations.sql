{% macro insert_audits (action_name) %}

insert into audits (type)
values ('{{ action_name }}');

commit;

{% endmacro %}