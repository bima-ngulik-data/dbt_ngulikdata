with 

source as (

    select * from {{ source('fivetran_gsheets', 'lynkid_orders') }}

),

renamed as (

    select

        -- transaction_info
        ref as transaction_id,
        PARSE_DATE('%m/%d/%Y', transaction_date) as transaction_date,
        status as transaction_status,
        notes_opsional_ as transaction_note,
        -- product_info
        judul_barang as product_name,
        harga as base_price,
        qty,
        sub_total,
        addon_detail,
        total_addon,
        -- fee_info
        affiliate_fee,
        notif_fee,
        public_affiliate_fee,
        shipping_fee,
        convenience_fee,
        total,
        -- buyer_info
        buyer_email as customer_email,
        buyer_name_opsional_ as customer_name,
        cast(buyer_phone_opsional_ as string) as customer_phone,
        -- promotion_info
        voucher,
        voucher_code,
        -- system_info
        _row,
        _fivetran_synced

    from source

)

select 
    transaction_id,
    transaction_date,
    transaction_status,
    transaction_note,
    product_name,
    base_price,
    qty,
    addon_detail,
    total_addon,
    sub_total,
    affiliate_fee,
    notif_fee,
    public_affiliate_fee,
    shipping_fee,
    convenience_fee,
    total,
    customer_email,
    customer_name,
    customer_phone,
    voucher,
    voucher_code,
    _row,
    _fivetran_synced
from renamed