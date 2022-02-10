{{ config(materialized='table') }}

-- definition of "active" --users who had an activity

    select 
        u.user_id
        , u.account_id
        , u.registered_at
        , u.persona
        , c.geo_region
        , c.geo_sub_region
        , coalesce(ac.billing_country, "none")
        , case when a.event_at is null then "yes"
            else "no" end as is_active 
        , acc.sales_rep_id
    from {{ref('users')}} as u
    left join {{ref('activity')}}  a
        on u.user_id = a.user_id
    left join {{ref('accounts')}}  ac
        on u.account_id = ac.account_id
    left join {{ref('country')}} c
        on a.country = c.country

    