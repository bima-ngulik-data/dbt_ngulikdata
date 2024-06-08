with 

source as (

    select * from {{ source('fivetran_gsheets', 'mayar_orders') }}

),

renamed as (

    select
        
        -- transasction_info
        id as transaction_id,
        invoice_id as invoice_id,
        status as transaction_status,
        PARSE_DATE('%m/%d/%Y', tanggal) as transaction_date,
        tipe as transaction_type,
        -- product_info
        nama_pembayaran as product_name,
        -- payment_info
        metode as payment_method,
        jumlah as base_amount,
        fee_channel as channel_fee,
        fee_mayar as platform_fee,
        nett as nett_amount,
        -- buyer_info
        nama as buyer_name,
        email as buyer_email,
        hp as buyer_phone,
        -- promotion_info
        kode_kupon as voucher_code,
        -- system_info
        _row,
        _fivetran_synced,

    from source

)

select 
   *
from renamed