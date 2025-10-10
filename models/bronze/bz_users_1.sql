/*
* Model: bz_users
* Description: Bronze layer table for user data from Zoom
*/

{{ config(
    materialized='table',
    unique_key='user_id'
) }}

-- Extract and transform data from raw users table
SELECT
    user_id,
    user_name,
    email,
    company,
    plan_type,
    -- Metadata columns
    CURRENT_TIMESTAMP() as load_timestamp,
    CURRENT_TIMESTAMP() as update_timestamp,
    'ZOOM_PLATFORM' as source_system
FROM ZOOM_DATABASE.RAW.users
