with source as (

    select *
    from {{ source('marketing_raw', 'snapchat_campaign_history') }}

),

cleaned as (

    select
        cast(campaign_id as string) as campaign_id,
        cast(account_id as string) as account_id,
        nullif(trim(campaign_name), '') as campaign_name

    from source

)

select *
from cleaned
