select
    platform,
    ad_date,
    ad_id,
    coalesce(country, '__NULL__') as country,
    count(*) as row_count

from {{ ref('fct_marketing_performance') }}

group by
    platform,
    ad_date,
    ad_id,
    coalesce(country, '__NULL__')

having count(*) > 1
