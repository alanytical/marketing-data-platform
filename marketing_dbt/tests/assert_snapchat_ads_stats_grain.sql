select
    ad_id,
    ad_date,
    country,
    count(*) as row_count

from {{ ref('stg_snapchat_ads_stats') }}

group by
    ad_id,
    ad_date,
    country

having count(*) > 1
