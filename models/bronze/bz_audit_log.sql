{{{
  config(
    materialized='table'
  )
}}}

-- Create audit log table to track processing of bronze models
SELECT
  1 AS record_id,
  'INITIALIZED' AS source_table,
  CURRENT_TIMESTAMP() AS load_timestamp,
  CURRENT_USER() AS processed_by,
  0 AS processing_time,
  'INITIALIZED' AS status
