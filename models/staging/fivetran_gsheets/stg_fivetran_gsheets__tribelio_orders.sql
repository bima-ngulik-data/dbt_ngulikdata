with

    source as (select * from {{ source("fivetran_gsheets", "tribelio_orders") }}),

    renamed as (

        select

            -- transaction info
            sales_id as transaction_id,
            status as transaction_status,
            cast(tanggal as date) as transaction_date,

            -- product info
            produk as product_name,
            price as product_price,

            -- buyer info
            email as buyer_email,
            name as buyer_name,
            phone as buyer_phone,

            -- payment info
            voucher_code,
            transaction_amount as transaction_amount,
            voucher_amount as discount_percentage,

            -- system info
            _row,
            _fivetran_synced,

        from source

    )

select *
from renamed
