{{
    config(
        materialized='incremental',
        unique_key='marketing_performance_key',
        incremental_strategy='merge',
        on_schema_change='sync_all_columns'
    )
}}

with facebook as (

    select *
    from {{ ref('int_facebook_performance') }}

),

snapchat as (

    select *
    from {{ ref('int_snapchat_performance') }}

),

unified as (

    select * from facebook

    union all

    select * from snapchat

),

final as (

    select

        md5(
            concat_ws(
                '||',
                platform,
                cast(ad_date as string),
                ad_id,
                coalesce(country, 'unknown')
            )
        ) as marketing_performance_key,

        ad_date,
        platform,

        account_id,
        account_name,

        campaign_id,
        campaign_name,

        ad_group_id,
        ad_group_name,

        ad_id,
        ad_name,

        country,
        currency_code,

        spend,
        impressions,
        clicks,

        case
            when impressions > 0
            then cast(clicks as double) / cast(impressions as double)
            else null
        end as ctr,

        case
            when clicks > 0
            then cast(spend as double) / cast(clicks as double)
            else null
        end as cpc,

        case
            when impressions > 0
            then (
                cast(spend as double)
                / cast(impressions as double)
            ) * 1000
            else null
        end as cpm

    from unified

)

select *
from final

{% if is_incremental() %}

where ad_date >= (
    select coalesce(
        date_sub(max(ad_date), 3),
        cast('1900-01-01' as date)
    )
    from {{ this }}
)

{% endif %}
