with source as (

    select *
    from {{ source('marketing_raw', 'snapchat_adgroup_history') }}

),

cleaned as (

    select
        cast(_surrogate_key as string) as source_surrogate_key,
        cast(ad_group_id as string) as ad_group_id,
        cast(campaign_id as string) as campaign_id,
        nullif(trim(ad_group_name), '') as ad_group_name,
        try_cast(ad_group_updated_at as timestamp) as ad_group_updated_at

    from source

),

ranked as (

    select
        *,
        row_number() over (
            partition by ad_group_id
            order by ad_group_updated_at desc, source_surrogate_key desc
        ) as row_num

    from cleaned

)

select
    source_surrogate_key,
    ad_group_id,
    campaign_id,
    ad_group_name,
    ad_group_updated_at

from ranked

where row_num = 1
