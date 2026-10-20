with source as (

    select *
    from {{ source('marketing_raw', 'snapchat_ads_history') }}

),

cleaned as (

    select
        cast(ad_id as string) as ad_id,
        cast(ad_group_id as string) as ad_group_id,
        nullif(trim(ad_name), '') as ad_name,
        try_cast(ad_detail_updated_at as timestamp) as ad_updated_at

    from source

)

select *
from cleaned
