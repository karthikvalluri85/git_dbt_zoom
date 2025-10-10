/*
* Model: bz_billing_events
* Description: Bronze layer table for billing event data from Zoom
*/

{{ config(
    materialized='table',
    unique_key='event_id'
) }}

-- Extract and transform data from raw billing_events table
SELECT
    event_id,
    user_id,
    event_type,
    amount,
    event_date,
    -- Metadata columns
    CURRENT_TIMESTAMP() as load_timestamp,
    CURRENT_TIMESTAMP() as update_timestamp,
    'ZOOM_PLATFORM' as source_system
FROM ZOOM_DATABASE.RAW.billing_events
