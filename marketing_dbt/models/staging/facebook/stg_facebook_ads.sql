with source as (

    select *
    from {{ source('marketing_raw', 'facebook_ads') }}

),

cleaned as (

    select
        cast(ad_id as string) as ad_id,
        cast(campaign_id as string) as campaign_id,
        cast(ad_group_id as string) as ad_group_id,
        cast(account_id as string) as account_id,
        nullif(trim(ad_name), '') as ad_name,
        upper(nullif(trim(ad_status), '')) as ad_status,
        try_cast(ad_updated_at as timestamp) as ad_updated_at

    from source

)

select *
from cleaned
