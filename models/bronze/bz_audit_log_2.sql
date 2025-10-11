-- Simple audit log model
SELECT
  1 as record_id,
  'test' as source_table,
  current_timestamp() as load_timestamp,
  current_user() as processed_by,
  0 as processing_time,
  'INITIALIZED' as status
