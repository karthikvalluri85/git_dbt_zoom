{{{
  config(
    materialized='table'
  )
}}}

-- Transform raw support_tickets data to bronze layer
SELECT
  ticket_id,
  user_id,
  ticket_type,
  resolution_status,
  open_date,
  load_timestamp,
  update_timestamp,
  source_system
FROM RAW.support_tickets
