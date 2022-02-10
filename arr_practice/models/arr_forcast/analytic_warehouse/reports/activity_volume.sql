{{ config(materialized='table') }}

select 
    a.event
    , cd.persona
    , cd.geo_region
    , count(*) as activity_volume
from {{ref('activity')}} a
join {{ref('activity')}} cd
    a.user_id = cd.user_id
group by 
    a.event
    , cd.persona
    , cd.geo_region