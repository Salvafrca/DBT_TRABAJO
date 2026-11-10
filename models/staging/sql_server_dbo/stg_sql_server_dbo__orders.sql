with orders as (                 
select * from {{ source('sql_server_dbo', 'orders') }}
),
enriched as (                    
select
order_id
, user_id as usuario
, address_id
, promo_id
, created_at
, estimated_delivery_at 
, delivered_at
, tracking_id
, shipping_service
, shipping_cost
, order_cost    
, order_total   
, status 
, _fivetran_deleted
, _fivetran_synced
from orders
)
select * from enriched           -- lógica-- final