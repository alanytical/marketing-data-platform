select *

from {{ ref('fct_marketing_performance') }}

where

    -- zero denominator handling
    (impressions = 0 and (ctr is not null or cpm is not null))

    or

    (clicks = 0 and cpc is not null)

    -- formula checks
    or

    (
        impressions > 0
        and abs(
            ctr - (
                cast(clicks as double)
                / cast(impressions as double)
            )
        ) > 0.0000001
    )

    or

    (
        clicks > 0
        and abs(
            cpc - (
                cast(spend as double)
                / cast(clicks as double)
            )
        ) > 0.0000001
    )

    or

    (
        impressions > 0
        and abs(
            cpm - (
                cast(spend as double)
                / cast(impressions as double)
                * 1000
            )
        ) > 0.0000001
    )
