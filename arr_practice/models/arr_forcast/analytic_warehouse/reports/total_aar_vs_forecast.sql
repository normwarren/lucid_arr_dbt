{{ config(materialized='table') }}

with arr_monthly as (
    select 
        d.month
        , arr.geo_sub_region
        , arr.arr_usd
    from {{ref('arr_fact')}} arr
    join {{ref('date_dim')}} d
    on arr.valid_from = d.day
    group by 
        d.month
        , arr.geo_sub_region
)
    select 
        geo_sub_region
        , d.month
        , farr.total_arr_usd as arr_forcasted_usd
        , arr.arr_usd as arr_actual_usd
    from {{ref('arr_forecast_fact')}} farr
    join {{ref('date_dim')}} d
        on farr.month = d.day
    join arr_monthly as arr
        on arr.month = farr.month
        and arr.geo_sub_region = farr.geo_sub_region
