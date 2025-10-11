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
  CURRENT_TIMESTAMP() AS load_timestamp,
  CURRENT_TIMESTAMP() AS update_timestamp,
  'ZOOM_PLATFORM' AS source_system
FROM {{ source('raw', 'support_tickets') }}
