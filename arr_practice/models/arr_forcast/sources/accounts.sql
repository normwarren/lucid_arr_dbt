
select * 
FROM {{ source('DB_RAW_DATA', 'accounts')}} AS A