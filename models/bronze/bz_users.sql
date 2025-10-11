{{{
  config(
    materialized='table',
    pre_hook=[
      "{% if execute and this.identifier != 'bz_audit_log' %}
        {% set start_time = modules.datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S') %}
        INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status)
        SELECT
          'users',
          CURRENT_TIMESTAMP(),
          CURRENT_USER(),
          0,
          'PROCESSING'
      {% endif %}"
    ],
    post_hook=[
      "{% if execute and this.identifier != 'bz_audit_log' %}
        INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status)
        SELECT
          'users',
          CURRENT_TIMESTAMP(),
          CURRENT_USER(),
          DATEDIFF('SECOND', '{{ run_started_at }}', CURRENT_TIMESTAMP()),
          'SUCCESS'
      {% endif %}"
    ]
  )
}}}

-- Transform raw users data to bronze layer
SELECT
  user_id,
  user_name,
  email,
  company,
  plan_type,
  CURRENT_TIMESTAMP() AS load_timestamp,
  CURRENT_TIMESTAMP() AS update_timestamp,
  'ZOOM_PLATFORM' AS source_system
FROM {{ source('raw', 'users') }}
