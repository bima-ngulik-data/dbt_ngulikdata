{{ config(materialized='ephemeral') }}

{% set platforms = ['lynkid', 'mayar', 'tribelio'] %}

with 

{% for platform in platforms %}

{{platform}}_customer as (
    select distinct
        customer_email,
        customer_name,
        customer_phone,
        '{{platform}}' as customer_source,
        min(transaction_date) as registered_at,
    from {{ ref('stg_fivetran_gsheets__'+platform+'_orders') }}
    group by 1,2,3,4
),

{% endfor%}

unioning_data as (

    {% for platform in platforms %}

    select *
    from {{platform}}_customer

    {% if not loop.last %}
    UNION ALL
    {% endif %}

    {%endfor%}
    
),

get_the_earliest_customer_info as (
    select 
        *
    from unioning_data
    qualify row_number() over(partition by customer_email order by registered_at) = 1
),

data_cleaning as (
    select
        customer_email,
        initcap(customer_name) as customer_name,
        case
            when length(cast(customer_phone as string)) < 9 then NULL
            when length(cast(customer_phone as string)) > 13 then NULL
            when left(customer_phone,3) = '+62' then customer_phone
            when left(customer_phone,1) = '8' then concat('+62',customer_phone)
            when left(customer_phone,1) = '6' then concat('+',customer_phone)
            when left(customer_phone,1) = '0' then concat('+62',substr(customer_phone,2))
            else null
        end as customer_phone,
        customer_source,
        registered_at
    from get_the_earliest_customer_info
    where
        customer_email not like '-'
)

select 
    customer_email,
    customer_name,
    customer_phone,
    customer_source,
    registered_at
from data_cleaning



