with customer_data as (
    select 
        customer_email,
        customer_name,
        customer_phone,
        customer_source,
        registered_at
    from {{ ref('int_combine_customer_data') }}
)

select 
    *
from customer_data