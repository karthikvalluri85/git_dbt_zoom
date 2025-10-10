/*
* Model: bz_audit_log
* Description: Audit log table to track processing of bronze layer models
*/

{{ config(
    materialized='table',
    unique_key='record_id'
) }}

-- Create audit log table with proper column types
SELECT
    CAST(NULL as NUMBER) as record_id,
    CAST('INITIAL_SETUP' as VARCHAR(255)) as source_table,
    CAST(CURRENT_TIMESTAMP() as TIMESTAMP_NTZ) as load_timestamp,
    CAST('DBT' as VARCHAR(100)) as processed_by,
    CAST(0 as NUMBER) as processing_time,
    CAST('SUCCESS' as VARCHAR(50)) as status
WHERE 1=0  -- Empty initial table
