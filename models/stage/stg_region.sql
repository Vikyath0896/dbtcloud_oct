{{ config(
   alias='stage_region'  
) }}

with region as(
select 
R_REGIONKEY as region_id,
R_NAME as name,
R_COMMENT as comment
from {{ source('src','regions')}}
)
select * from region