
select * 
FROM {{ source('DB_RAW_DATA', 'forecast')}} AS A