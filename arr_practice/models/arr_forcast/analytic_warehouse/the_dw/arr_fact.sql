{{ config(materialized='table') }}

select 
    s.account_id
    , s.arr_usd
    , s.valid_from
    , s.valid_to
    , r.sales_rep_id
    , c.geo_sub_region
from {{ref('subscription_log')}} as s
left join {{ref('accounts')}} as a
    on s.account_id = a.account_id
left join {{ref('sales_representatives')}} as r
    on a.sales_rep_id = r.sales_rep_id
left join {{ref('countries')}} as c
    on a.country = a.billing_country   
