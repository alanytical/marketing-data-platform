select *

from {{ ref('stg_snapchat_ads_stats') }}

where
       spend < 0
    or impressions < 0
    or clicks < 0
