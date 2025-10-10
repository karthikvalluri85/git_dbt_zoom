/*
* Model: bz_meetings
* Description: Bronze layer table for meeting data from Zoom
*/

{{ config(
    materialized='table',
    unique_key='meeting_id'
) }}

-- Extract and transform data from raw meetings table
SELECT
    meeting_id,
    host_id,
    meeting_topic,
    start_time,
    end_time,
    duration_minutes,
    -- Metadata columns
    CURRENT_TIMESTAMP() as load_timestamp,
    CURRENT_TIMESTAMP() as update_timestamp,
    'ZOOM_PLATFORM' as source_system
FROM {{ source('raw', 'meetings') }}
