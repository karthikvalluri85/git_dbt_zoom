/*
* Macro: log_audit_start
* Description: Logs the start of a model processing to the audit log table
*/
{% macro log_audit_start(source_table) %}
  {% if execute and not flags.WHICH == 'generate' %}
    {% set query %}
      INSERT INTO {{ ref('bz_audit_log') }} (
        source_table,
        load_timestamp,
        processed_by,
        processing_time,
        status
      )
      SELECT
        '{{ source_table }}',
        CURRENT_TIMESTAMP(),
        'DBT',
        0,
        'PROCESSING'
      {% endset %}
      {% do run_query(query) %}
  {% endif %}
{% endmacro %}

/*
* Macro: log_audit_end
* Description: Logs the end of a model processing to the audit log table
*/
{% macro log_audit_end(source_table, status) %}
  {% if execute and not flags.WHICH == 'generate' %}
    {% set query %}
      INSERT INTO {{ ref('bz_audit_log') }} (
        source_table,
        load_timestamp,
        processed_by,
        processing_time,
        status
      )
      SELECT
        '{{ source_table }}',
        CURRENT_TIMESTAMP(),
        'DBT',
        DATEDIFF('SECOND', (
          SELECT MAX(load_timestamp)
          FROM {{ ref('bz_audit_log') }}
          WHERE source_table = '{{ source_table }}'
          AND status = 'PROCESSING'
        ), CURRENT_TIMESTAMP()),
        '{{ status }}'
      {% endset %}
      {% do run_query(query) %}
  {% endif %}
{% endmacro %}
