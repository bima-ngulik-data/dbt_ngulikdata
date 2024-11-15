{{ config(materialized='ephemeral') }}

-- get transaction data

with transactions as (
    select
        customer_email,
        transaction_id,
        transaction_date,
        transaction_amount,
        product_name,
        product_price

    from {{ ref('fct_transactions') }}
),

-- aggregating transaction data
aggregate_transactions as (

    select
        customer_email,
        
        count(if(product_price > 0, transaction_id, null)) as count_paid_transactions,
        count(if(product_price = 0, transaction_id, null)) as count_free_transactions,

        min(if(product_price > 0, transaction_date, null)) as first_paid_transactions_at,
        min(if(product_price = 0, transaction_date, null)) as first_free_transactions_at,

        max(if(product_price > 0, transaction_date, null)) as last_paid_transactions_at,
        max(if(product_price = 0, transaction_date, null)) as last_free_transactions_at,

        sum(transaction_amount) as transaction_amount,

        count(distinct if(product_price > 0, product_name, null)) as count_paid_product_purchased,
        count(distinct if(product_price = 0, product_name, null)) as count_free_product_purchased,

    from transactions
    group by customer_email
),

customer_label as (

    select
        *,
        case
            when count_paid_transactions > 0 then 'paid_customer'
            when count_free_transactions > 0 then 'freebies_customer'
        end as lead_type
    from aggregate_transactions
)

select 

    customer_email,
    lead_type,
    count_paid_transactions,
    count_free_transactions,
    first_paid_transactions_at,
    first_free_transactions_at,
    last_paid_transactions_at,
    last_free_transactions_at,
    transaction_amount,
    count_paid_product_purchased,
    count_free_product_purchased
    
from customer_label