/*
* Model: bz_audit_log
* Description: Audit log table to track processing of bronze layer models
*/

{{ config(
    materialized='table',
    unique_key='record_id'
) }}

-- Create audit log table if it doesn't exist
SELECT
    NULL as record_id,
    'INITIAL_SETUP' as source_table,
    CURRENT_TIMESTAMP() as load_timestamp,
    'DBT' as processed_by,
    0 as processing_time,
    'SUCCESS' as status
WHERE 1=0  -- Empty initial table
