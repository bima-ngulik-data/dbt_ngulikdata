with source as (
    
    select * from {{ source("fivetran_gsheets", "tribelio_orders") }}

),

renamed as (

    select

        -- transaction info
        transaction_id,
        status as transaction_status,
        date as transaction_date,

        -- product info
        product_name,
        price as product_price,

        -- buyer info
        email as customer_email,
        name as customer_name,
        cast(phone as string) as customer_phone,

        -- payment info
        type as transaction_type,
        voucher as voucher_code,
        amount as transaction_amount,
        commision,
        net_profit,

        -- system info
        _row,
        _fivetran_synced,

    from source

)

select *
from renamed
