SELECT
  user_id,
  user_name,
  email,
  company,
  plan_type,
  current_timestamp() as load_timestamp,
  current_timestamp() as update_timestamp,
  'ZOOM_PLATFORM' as source_system
FROM {{ source('raw', 'users') }}
