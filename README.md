# Marketing Data Platform with Databricks & dbt

## Overview

This project builds a production-minded marketing data platform that combines Facebook Ads and Snapchat Ads data in Databricks using dbt.

The final analytical model provides a consistent view of spend, impressions, clicks, CTR, CPC and CPM across both platforms.

## Tech Stack

- Databricks
- Unity Catalog
- dbt Core
- dbt-databricks
- Elementary
- GitHub Actions
- Python / uv

## Architecture

```text
Facebook + Snapchat CSVs
          ↓
workspace.marketing_raw
          ↓
dbt staging models
          ↓
intermediate models
          ↓
fct_marketing_performance
          ↓
Analysts / BI / AI
```
## dbt Layers

### Staging
Cleans raw data, standardizes column names and data types, and handles source-specific fields.

### Intermediate
Joins performance data with account, campaign, ad-group and ad metadata.

### Mart
The final analytical model is `fct_marketing_performance`.
## Grain

Facebook:
`ad_id + ad_date`

Snapchat:
`ad_id + ad_date + country`

## Metrics

- CTR = clicks / impressions
- CPC = spend / clicks
- CPM = (spend / impressions) * 1000

Zero denominators return NULL.
## Data Quality

dbt tests cover:

- uniqueness
- not-null values
- accepted platform values
- duplicate protection
- non-negative metrics
- metric calculations

Validated build:

`PASS=51 WARN=0 ERROR=0`
## Environments

Separate Databricks schemas are used for:

- development
- staging
- CI
- production

Production uses a Databricks Service Principal with OAuth authentication.
## Observability

Elementary is configured to monitor:

- dbt test results
- model health
- data quality
- historical test behavior.
## CI/CD

Pull requests run dbt validation in the CI environment.

Pushes to `main` deploy to production using GitHub Actions and Databricks Service Principal authentication.

## Engineering Decisions

- Staging and intermediate models use views for lightweight transformations.
- The final marketing fact model is incremental to avoid unnecessary full rebuilds.
- Snapchat history data is deduplicated before joining.
- Facebook and Snapchat retain their correct source grains.
- CI and production use separate schemas.
- Production uses a Service Principal instead of personal credentials.

## Run Locally

```bash
uv sync
cd marketing_dbt
uv run dbt deps
uv run dbt debug --target dev
uv run dbt build --target dev
