{{ config(materialized='ephemeral') }}

with lynkid_transactions as (
    select 
        transaction_id,
        transaction_date,
        transaction_status,
        product_name,
        customer_email,
        base_price as product_price,
        qty as quantity,
        total_addon as addon_amount,
        (base_price*qty) + total_addon as total_price,
        voucher as discount_amount,
        ((base_price*qty) + total_addon) - voucher as transaction_amount,
        affiliate_fee + notif_fee + public_affiliate_fee + shipping_fee + convenience_fee as total_fee,
        (((base_price*qty) + total_addon) - voucher) - (affiliate_fee + notif_fee + public_affiliate_fee + shipping_fee + convenience_fee) as net_amount
    from {{ ref('stg_fivetran_gsheets__lynkid_orders') }}
    where transaction_status = 'SUCCESS'
),

tribelio_transactions as (
    select 
        transaction_id,
        transaction_date,
        transaction_status,
        product_name,
        customer_email,
        product_price,
        transaction_amount,
        product_price - transaction_amount as discount_amount,
        commision as total_fee,
        net_profit as net_amount
    from {{ ref('stg_fivetran_gsheets__tribelio_orders') }}
    where transaction_status = 'SUCCESS'
),

combining_data as (
    select
        transaction_id,
        transaction_date,
        transaction_status,
        product_name,
        customer_email,
        product_price,
        quantity,
        addon_amount,
        total_price,
        discount_amount,
        transaction_amount,
        total_fee,
        net_amount
    from lynkid_transactions

    union all 

    select
        transaction_id,
        transaction_date,
        transaction_status,
        product_name,
        customer_email,
        product_price,
        1 as quantity,
        0 as addon_amount,
        product_price as total_price,
        discount_amount,
        transaction_amount,
        total_fee,
        net_amount
    from tribelio_transactions
)

select
    transaction_id,
    transaction_date,
    transaction_status,
    product_name,
    customer_email,
    product_price,
    quantity,
    addon_amount,
    total_price,
    discount_amount,
    transaction_amount,
    total_fee,
    net_amount
from combining_data