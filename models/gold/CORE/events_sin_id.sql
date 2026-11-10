{% set excluidos = ['event_id'] %}
with events as (
    select {{dbt_utils.star(from=ref('slv_sql_server_dbo__events'), except = excluidos )}}
    from {{ref('slv_sql_server_dbo__events')}}
)
select *
    from events