with transaction_data as (
    select 
        transaction_id,
        transaction_date,
        transaction_status,
        transaction_note,
        product_name,
        product_price,
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
        buyer_email,
        buyer_name,
        buyer_phone,
        voucher,
        voucher_code,
        _row,
        _fivetran_synced
    from {{ ref('stg_lynkid_orders') }}
)

select *
from transaction_data