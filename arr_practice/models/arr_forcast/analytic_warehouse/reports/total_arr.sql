{{ config(materialized='table') }}

select 
    s.sales_team
    , d.fy_quarter
    , aar.arr_usd
from {{ref('arr_fact')}} as aar
join {{ref('sales_representatives')}} as s
    on aar.sales_rep_id = s.sales_rep_id
join {{ref('date_dim')}} as d
    on (aar.valid_from >= d.fs_quarter_start 
    AND aar.valid_to <= d.fs_quarter_end
group by 
    s.sales_team
    , d.fy_quarter