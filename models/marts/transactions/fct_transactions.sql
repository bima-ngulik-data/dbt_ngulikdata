with transaction_data as (

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
    from {{ ref('int_combine_transaction_data') }}

),

product_details as (
    select 
        platform_item_name,
        product_name,
        product_type,
    from {{ ref('stg_fivetran_gsheets__lynkid_products') }}
),

combining_data as (
    select 
        t.* except (product_name),
        coalesce(pd.product_name, t.product_name) as product_name,
        product_type
    from transaction_data as t
    left join product_details as pd
        on t.product_name = pd.platform_item_name
)

select
    transaction_id,
    transaction_date,
    transaction_status,
    product_name,
    product_type,
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