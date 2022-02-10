{{ config(materialized='table') }}

select 
    a.user_id
    , a.event
    , a.event_at
    , c.billing_country
    , cd.persona
from {{ref('activity')}} as a
left join {{ref('customer_dim')}} as cd
    on a.user_id = cd.user_id
left join {{ref('country')}}
    on cd.billing_country = c.country 