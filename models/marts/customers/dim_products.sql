with raw_transaction as (
    select
        product_name,
        product_price,
    from {{ ref('stg_fivetran_gsheets__lynkid_orders') }}
)

select distinct
    product_name
from raw_transaction