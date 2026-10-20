with source as (

    select *
    from {{ source('marketing_raw', 'facebook_campaigns') }}

),

cleaned as (

    select
        cast(campaign_id as string) as campaign_id,
        nullif(trim(campaign_name), '') as campaign_name,
        try_cast(campaign_updated_at as timestamp) as campaign_updated_at

    from source

)

select *
from cleaned
