{{{
  config(
    materialized='table',
    pre_hook=[
      "INSERT INTO {{ this.schema }}.bz_audit_log (source_table, load_timestamp, processed_by, processing_time, status) 
       SELECT 'support_tickets', CURRENT_TIMESTAMP(), CURRENT_USER(), 0, 'PROCESSING'"
    ],
    post_hook=[
      "INSERT INTO {{ this.schema }}.bz_audit_log (source_table, load_timestamp, processed_by, processing_time, status) 
       SELECT 'support_tickets', CURRENT_TIMESTAMP(), CURRENT_USER(), DATEDIFF('SECOND', CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP()), 'SUCCESS'"
    ]
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
FROM RAW.support_tickets
