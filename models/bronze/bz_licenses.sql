/*
* Model: bz_licenses
* Description: Bronze layer table for license data from Zoom
*/

{{ config(
    materialized='table',
    unique_key='license_id'
) }}

-- Extract and transform data from raw licenses table
SELECT
    license_id,
    license_type,
    assigned_to_user_id,
    start_date,
    end_date,
    -- Metadata columns
    CURRENT_TIMESTAMP() as load_timestamp,
    CURRENT_TIMESTAMP() as update_timestamp,
    'ZOOM_PLATFORM' as source_system
FROM ZOOM_DATABASE.RAW.licenses
