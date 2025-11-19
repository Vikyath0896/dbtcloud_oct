
with info as(
select
   n.nation_id,n.name nation_name,n.n_regionid ,r.name region_name,n.comment
from {{ ref('stg_nations') }} as n
join {{ ref('stg_region') }} as r
    on n.n_regionid = r.region_id
)
select * from info



