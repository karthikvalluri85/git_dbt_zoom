/*
* Model: bz_feature_usage
* Description: Bronze layer table for feature usage data from Zoom
*/

{{ config(
    materialized='table',
    unique_key='usage_id'
) }}

-- Extract and transform data from raw feature_usage table
SELECT
    usage_id,
    meeting_id,
    feature_name,
    usage_count,
    usage_date,
    -- Metadata columns
    CURRENT_TIMESTAMP() as load_timestamp,
    CURRENT_TIMESTAMP() as update_timestamp,
    'ZOOM_PLATFORM' as source_system
FROM ZOOM_DATABASE.RAW.feature_usage
