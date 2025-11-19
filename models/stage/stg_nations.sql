{{ config(
   query_tag='test1' ,
   alias=this.name + var('v_id')
) }}


with nation as (
    select 
        n_nationkey as nation_id,
        n_name as name,
        n_regionkey as region_id,
        n_comment as comments,
        {{ jodo('n_name', 'n_comment') }} as jodo_col,
        updated_at
    from {{ source ('src', 'nations') }}
)

select * from nation
