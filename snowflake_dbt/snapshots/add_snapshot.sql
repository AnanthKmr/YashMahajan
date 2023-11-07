{% snapshot add_snapshot %}

{{
    config(
      target_database='demo_database',
      target_schema='snap_shot_schema',
      unique_key='stdid',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from {{ source('student_s', 'student') }} a

{% endsnapshot %}
