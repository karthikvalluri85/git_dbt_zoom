{{{
  config(
    materialized='table'
  )
}}}

-- Transform raw billing_events data to bronze layer
SELECT
  event_id,
  user_id,
  event_type,
  amount,
  event_date,
  load_timestamp,
  update_timestamp,
  source_system
FROM RAW.billing_events
