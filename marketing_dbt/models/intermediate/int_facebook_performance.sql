with stats as (

    select *
    from {{ ref('stg_facebook_ads_stats') }}

),

ads as (

    select *
    from {{ ref('stg_facebook_ads') }}

),

adgroups as (

    select *
    from {{ ref('stg_facebook_adgroups') }}

),

campaigns as (

    select *
    from {{ ref('stg_facebook_campaigns') }}

),

accounts as (

    select *
    from {{ ref('stg_facebook_accounts') }}

),

final as (

    select
        'facebook' as platform,
        stats.ad_date,

        stats.account_id,
        accounts.account_name,

        ads.campaign_id,
        campaigns.campaign_name,

        ads.ad_group_id,
        adgroups.ad_group_name,

        stats.ad_id,
        ads.ad_name,

        cast(null as string) as country,
        accounts.currency_code,

        stats.spend,
        stats.impressions,
        stats.clicks

    from stats

    left join ads
        on stats.ad_id = ads.ad_id

    left join accounts
        on stats.account_id = accounts.account_id

    left join campaigns
        on ads.campaign_id = campaigns.campaign_id

    left join adgroups
        on ads.ad_group_id = adgroups.ad_group_id

)

select *
from final
