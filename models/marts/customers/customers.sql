-- get customer data
with customers as (
    select
        *
    from {{ ref('dim_customers') }}
),

-- lead customer type
lead_type as (
    select 
        *
    from {{ ref('int_labelling_lead_customer_type') }}
),

combining_data as (
    select *
    from customers
    left join lead_type
        using (customer_email)
)


select *
from combining_data

