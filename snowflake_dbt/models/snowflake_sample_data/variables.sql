

{% set payment_methods = [101, 102, 103] %}
select
customer_id,
{% for payment_method in payment_methods %}
sum(case when payment_method = '{{payment_method}}' then order_id end) as {{payment_method}}_amount,
{% endfor %}
sum(order_id) as total_amount
from {{ ref('source_sales') }}
group by 1