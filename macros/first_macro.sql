


{%macro jodo(col1,col2) %}
    {{col1}} || ' ' ||{{col2}}
{% endmacro %}


{% macro gender(gn) %}
CASE
    WHEN {{ gn }} = 'M' THEN 'Male'
    WHEN {{ gn }} = 'F' THEN 'Female'
    ELSE 'Unknown'
END
{% endmacro %}

{% macro age_group(employee_age) %}
CASE
    WHEN {{ employee_age }} < 25 THEN 'Youngster'
    WHEN {{ employee_age }} < 60 THEN 'Middle'
    ELSE 'Senior'
END
{% endmacro %}

{% macro phone(ph) %}
'(' || SUBSTR({{ ph }}, 1, 3) || ') ' || SUBSTR({{ ph }}, 4, 3) || '-' || SUBSTR({{ ph }}, 7)
{% endmacro %}


{% macro show_emps() %}
    select name from stg_employees
{% endmacro %}//dbt can run select statements only inside the models


{% macro show_emps1() %}
    {% set results = run_query("select name from stg_employees") %}
    {{ results }}
    {% do run_query(results) %}
{% endmacro %}

{% macro create_stage() %}
  {% do run_query("create stage stage_analytics")%};
{% endmacro %}


{% macro unload_data() %}
    {% do run_query(
        "copy into @ANALYTICS.DBT_VIKYATH.STAGE_ANALYTICS/nations/ from " ~ ref('stg_employees') ~ 
        " file_format = (type = csv compression = none) header = true"
    ) %}
{% endmacro %}


{% macro mod_tab(table_name) %}
    {{ dbt_utils.get_filtered_columns_in_relation(ref("stg_nations")) | join(', ') }}
{% endmacro %}
