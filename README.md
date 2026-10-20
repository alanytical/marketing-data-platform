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
