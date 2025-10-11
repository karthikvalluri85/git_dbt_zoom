{% macro log_audit_start(source_table) %}
  INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status)
  SELECT
    '{{ source_table }}',
    CURRENT_TIMESTAMP(),
    CURRENT_USER(),
    0,
    'PROCESSING'
  {% if this.identifier != 'bz_audit_log' %}
  {% endif %}
{% endmacro %}

{% macro log_audit_end(source_table, start_time) %}
  INSERT INTO {{ ref('bz_audit_log') }} (source_table, load_timestamp, processed_by, processing_time, status)
  SELECT
    '{{ source_table }}',
    CURRENT_TIMESTAMP(),
    CURRENT_USER(),
    DATEDIFF('SECOND', '{{ start_time }}', CURRENT_TIMESTAMP()),
    'SUCCESS'
  {% if this.identifier != 'bz_audit_log' %}
  {% endif %}
{% endmacro %}
