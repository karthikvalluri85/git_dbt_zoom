/*
* Model: bz_participants
* Description: Bronze layer table for participant data from Zoom
*/

{{ config(
    materialized='table',
    unique_key='participant_id'
) }}

-- Extract and transform data from raw participants table
SELECT
    participant_id,
    meeting_id,
    user_id,
    join_time,
    leave_time,
    -- Metadata columns
    CURRENT_TIMESTAMP() as load_timestamp,
    CURRENT_TIMESTAMP() as update_timestamp,
    'ZOOM_PLATFORM' as source_system
FROM ZOOM_DATABASE.RAW.participants
