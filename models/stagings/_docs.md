# Documentations

## stg_lynkid_orders

{% docs lynkid_orders_transaction_id %}
A unique identifier for each transaction, corresponding to the 'ref' field in the source data.
{% enddocs %}

{% docs lynkid_orders_transaction_date %}
The date when the transaction occurred.
{% enddocs %}

{% docs lynkid_orders_transaction_status %}
The status of the transaction, such as completed, pending, or cancelled.
{% enddocs %}

{% docs lynkid_orders_transaction_note %}
Optional notes associated with the transaction.
{% enddocs %}

{% docs lynkid_orders_product_name %}
The name of the product involved in the transaction.
{% enddocs %}

{% docs lynkid_orders_product_price %}
The price of the product at the time of the transaction.
{% enddocs %}

{% docs lynkid_orders_qty %}
The quantity of the product purchased in the transaction.
{% enddocs %}

{% docs lynkid_orders_sub_total %}
The subtotal of the order before fees and addon. calculated from qty*product_price
{% enddocs %}

{% docs lynkid_orders_addon_detail %}
Details about any add-ons purchased along with the main product.
{% enddocs %}

{% docs lynkid_orders_total_addon %}
The total amount of the add-ons.
{% enddocs %}

{% docs lynkid_orders_affiliate_fee %}
The fee associated with the affiliate who facilitated the sale.
{% enddocs %}

{% docs lynkid_orders_notif_fee %}
Notification fee charged, if any, as part of the transaction.
{% enddocs %}

{% docs lynkid_orders_public_affiliate_fee %}
A public fee that is shared or visible outside the internal systems, often related to affiliate marketing.
{% enddocs %}

{% docs lynkid_orders_shipping_fee %}
The shipping fee charged for the transaction.
{% enddocs %}

{% docs lynkid_orders_convenience_fee %}
A fee charged for the convenience of using a specific payment method or service.
{% enddocs %}

{% docs lynkid_orders_total %}
The total amount paid by the buyer, including all products, add-ons, and fees.
{% enddocs %}

{% docs lynkid_orders_buyer_email %}
The email address of the buyer.
{% enddocs %}

{% docs lynkid_orders_buyer_name %}
The name of the buyer, which may be optional.
{% enddocs %}

{% docs lynkid_orders_buyer_phone %}
The phone number of the buyer, which may be optional.
{% enddocs %}

{% docs lynkid_orders_voucher %}
Indicates whether a voucher was used in the transaction.
{% enddocs %}

{% docs lynkid_orders_voucher_code %}
The code of the voucher used, if applicable.
{% enddocs %}

{% docs lynkid_orders__row %}
An internal identifier or row number within the source system, used for tracking changes or updates.
{% enddocs %}

{% docs lynkid_orders__fivetran_synced %}
The timestamp of the last synchronization with Fivetran, indicating the last update time of this record in the data warehouse.
{% enddocs %}
