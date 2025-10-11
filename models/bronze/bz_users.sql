{{{
  config(
    materialized='table',
    pre_hook=[
      "INSERT INTO {{ this.schema }}.bz_audit_log (source_table, load_timestamp, processed_by, processing_time, status) 
       SELECT 'users', CURRENT_TIMESTAMP(), CURRENT_USER(), 0, 'PROCESSING'"
    ],
    post_hook=[
      "INSERT INTO {{ this.schema }}.bz_audit_log (source_table, load_timestamp, processed_by, processing_time, status) 
       SELECT 'users', CURRENT_TIMESTAMP(), CURRENT_USER(), DATEDIFF('SECOND', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()), 'SUCCESS'"
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
FROM RAW.users
