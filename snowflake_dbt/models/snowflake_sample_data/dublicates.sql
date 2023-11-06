
{{ dbt_utils.deduplicate(
    relation=ref('emp_model'),
    partition_by='empname',
    order_by='empid',
   )
}}




