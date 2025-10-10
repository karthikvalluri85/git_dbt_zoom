/*
* Model: bz_webinars
* Description: Bronze layer table for webinar data from Zoom
*/

{{ config(
    materialized='table',
    unique_key='webinar_id'
) }}

-- Extract and transform data from raw webinars table
SELECT
    webinar_id,
    host_id,
    webinar_topic,
    start_time,
    end_time,
    registrants,
    -- Metadata columns
    CURRENT_TIMESTAMP() as load_timestamp,
    CURRENT_TIMESTAMP() as update_timestamp,
    'ZOOM_PLATFORM' as source_system
FROM ZOOM_DATABASE.RAW.webinars
