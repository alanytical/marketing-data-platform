with source as (

    select *
    from {{ source('marketing_raw', 'facebook_adgroups') }}

),

cleaned as (

    select
        cast(ad_group_id as string) as ad_group_id,
        nullif(trim(ad_group_name), '') as ad_group_name,
        try_cast(ad_group_updated_at as timestamp) as ad_group_updated_at

    from source

)

select *
from cleaned
