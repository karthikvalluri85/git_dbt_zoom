/*
* Model: bz_support_tickets
* Description: Bronze layer table for support ticket data from Zoom
*/

{{ config(
    materialized='table',
    unique_key='ticket_id'
) }}

-- Extract and transform data from raw support_tickets table
SELECT
    ticket_id,
    user_id,
    ticket_type,
    resolution_status,
    open_date,
    -- Metadata columns
    CURRENT_TIMESTAMP() as load_timestamp,
    CURRENT_TIMESTAMP() as update_timestamp,
    'ZOOM_PLATFORM' as source_system
FROM ZOOM_DATABASE.RAW.support_tickets
