{{{
  config(
    materialized='table'
  )
}}}

-- Transform raw feature_usage data to bronze layer
SELECT
  usage_id,
  meeting_id,
  feature_name,
  usage_count,
  usage_date,
  load_timestamp,
  update_timestamp,
  source_system
FROM RAW.feature_usage
