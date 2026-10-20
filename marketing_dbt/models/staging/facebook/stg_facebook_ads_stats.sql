with source as (

    select *
    from {{ source('marketing_raw', 'facebook_ads_stats') }}

),

cleaned as (

    select
        cast(ad_id as string) as ad_id,
        cast(account_id as string) as account_id,

        try_cast(nullif(trim(ad_spend), '') as decimal(18, 6)) as spend,
        try_cast(nullif(trim(ad_impressions), '') as bigint) as impressions,
        try_cast(nullif(trim(ad_clicks), '') as bigint) as clicks,
        try_cast(nullif(trim(ad_date), '') as date) as ad_date

    from source

)

select *
from cleaned
