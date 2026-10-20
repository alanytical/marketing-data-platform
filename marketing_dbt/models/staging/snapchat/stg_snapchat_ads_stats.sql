with source as (

    select *
    from {{ source('marketing_raw', 'snapchat_ads_stats') }}

),

cleaned as (

    select
        cast(ad_detail_id as string) as ad_id,
        upper(nullif(trim(ad_currency_code), '')) as currency_code,
        lower(nullif(trim(ad_country), '')) as country,
        try_cast(nullif(trim(ad_spend), '') as decimal(18, 6)) as spend,
        try_cast(nullif(trim(ad_impressions), '') as bigint) as impressions,
        try_cast(nullif(trim(ad_clicks), '') as bigint) as clicks,
        try_cast(nullif(trim(ad_date), '') as date) as ad_date,
        lower(nullif(trim(data_src), '')) as data_source

    from source

)

select *
from cleaned
