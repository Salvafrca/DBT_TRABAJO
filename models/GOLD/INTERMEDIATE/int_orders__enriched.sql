-- =============================================================================
-- int_orders__enriched
-- =============================================================================
-- Intermedio de Gold: une cada pedido con su dirección y su promoción.
-- No se expone al consumo; lo usa fct_orders. Vive en el schema intermediate.
-- =============================================================================

with orders as (
    select * from {{ ref('slv_sql_server_dbo__orders') }}
),

addresses as (
    select * from {{ ref('slv_sql_server_dbo__addresses') }}
),

promos as (
    select * from {{ ref('slv_sql_server_dbo__promos') }}
),

joined as (
    select
          o.order_id
        , o.usuario
        , o.address_id
        , a.country                                         as shipping_country
        , o.promo_id
        , coalesce(p.discount_usd, 0)                       as discount_usd
        , coalesce(p.promo_status, 'no_promo')              as promo_status
        , o.created_at
        , o.estimated_delivery_at
        , o.delivered_at
        , datediff('day', o.created_at, o.delivered_at) as days_to_deliver
        , o.tracking_id
        , o.shipping_service
        , o.shipping_cost
        , o.order_cost
        , o.order_total
        , o.status
        , o._fivetran_synced
    from orders o
    left join addresses a on o.address_id = a.address_id
    left join promos    p on o.promo_id   = p.promo_id
)

select * from joined
