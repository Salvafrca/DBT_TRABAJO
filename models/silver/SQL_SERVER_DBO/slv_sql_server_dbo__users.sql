
with users as (
    select * from {{ source('sql_server_dbo', 'users') }}
),

renamed as (
    select
        user_id
        , first_name
        , last_name
        , email
        , phone_number
        , address_id
        , created_at
        , updated_at
        , _fivetran_deleted
        , _fivetran_synced
        , _loaded_at
        --, is_deleted
    from users
    --where not is_deleted
    qualify row_number() over (partition by user_id order by _fivetran_synced desc) = 1
)

select * from renamed
