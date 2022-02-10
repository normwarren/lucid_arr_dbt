{{ config(materialized='table') }}

select 
    , cd.persona
    , dm.day as activity_day
    count(distinct cd.user_id) as active_users
from {{ref('customer_dim')}} as cd
inner join {{ref('activity')}} a
    on cd.event_at = dm.day
join {{ref('date_dim')}} as dm
    on a.user_id = cd.user_id
where is_active = "yes"
group by cd.persona, dm.day