with 

source as (

    select * from {{ source('fivetran_gsheets', 'lynkid_products') }}

),

renaming as (
    
    select
        lynkid_name as platform_item_name,
        product_name,
        product_type,
        parse_date('%m/%d/%Y', published_at) as published_at,
        is_pay_as_you_wish,
        is_active,
        _fivetran_synced,
        _row

    from source
)

select 
    platform_item_name,
    product_name,
    product_type,
    published_at,
    is_pay_as_you_wish,
    is_active,
    _fivetran_synced,
    _row
from renaming