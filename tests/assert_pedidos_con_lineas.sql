WITH ORDERS AS (
    select *
    FROM {{ref(' fct_orders')}}    
)
,  ORDERS_ITEMS AS (
    SELECT *
    FROM {{ref('fct_orders_items')}}

)

select *
FROM ORDERS O LEFT JOIN ORDERS_ITEMS I
    ON O.order_id = I.order_id
WHERE i.order_id is null