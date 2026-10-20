with source as (

    select *
    from {{ source('marketing_raw', 'facebook_accounts') }}

),

cleaned as (

    select
        cast(account_id as string) as account_id,
        nullif(trim(account_name), '') as account_name,
        upper(nullif(trim(ad_currency_code), '')) as currency_code,
        try_cast(account_created_at as timestamp) as account_created_at,
        try_cast(account_updated_at as timestamp) as account_updated_at

    from source

)

select *
from cleaned
