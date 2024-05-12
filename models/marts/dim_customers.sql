with transaction_data as (
    select 
        buyer_email,
        buyer_name,
        buyer_phone
    from {{ ref('stg_lynkid_orders') }}
)

select distinct
    buyer_email,
    buyer_name,
    buyer_phone,
from transaction_data