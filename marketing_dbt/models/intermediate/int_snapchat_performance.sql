with stats as (

    select *
    from {{ ref('stg_snapchat_ads_stats') }}

),

ads as (

    select *
    from {{ ref('stg_snapchat_ads') }}

),

adgroups as (

    select *
    from {{ ref('stg_snapchat_adgroups') }}

),

campaigns as (

    select *
    from {{ ref('stg_snapchat_campaigns') }}

),

final as (

    select
        'snapchat' as platform,
        stats.ad_date,

        campaigns.account_id,
        cast(null as string) as account_name,

        adgroups.campaign_id,
        campaigns.campaign_name,

        ads.ad_group_id,
        adgroups.ad_group_name,

        stats.ad_id,
        ads.ad_name,

        stats.country,
        stats.currency_code,

        stats.spend,
        stats.impressions,
        stats.clicks

    from stats

    left join ads
        on stats.ad_id = ads.ad_id

    left join adgroups
        on ads.ad_group_id = adgroups.ad_group_id

    left join campaigns
        on adgroups.campaign_id = campaigns.campaign_id

)

select *
from final
