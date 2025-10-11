{{{
  config(
    materialized='table',
    pre_hook=[
      "INSERT INTO {{ this.schema }}.bz_audit_log (source_table, load_timestamp, processed_by, processing_time, status) 
       SELECT 'feature_usage', CURRENT_TIMESTAMP(), CURRENT_USER(), 0, 'PROCESSING'"
    ],
    post_hook=[
      "INSERT INTO {{ this.schema }}.bz_audit_log (source_table, load_timestamp, processed_by, processing_time, status) 
       SELECT 'feature_usage', CURRENT_TIMESTAMP(), CURRENT_USER(), DATEDIFF('SECOND', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()), 'SUCCESS'"
    ]
  )
}}}

-- Transform raw feature_usage data to bronze layer
SELECT
  usage_id,
  meeting_id,
  feature_name,
  usage_count,
  usage_date,
  CURRENT_TIMESTAMP() AS load_timestamp,
  CURRENT_TIMESTAMP() AS update_timestamp,
  'ZOOM_PLATFORM' AS source_system
FROM RAW.feature_usage
