# the multi- vs unified workspace approach to databricks
## executive summary

## overview
currently within our current databricks ecosystem, there are two primary distinctions:
1) internal (IC) vs external clients (EC)
2) analytics products (AP) vs data products (DP)

within the analytics data environment (ADE), the two primary distinctions split out into two separate platforms -- which are themselves split into two separate "workspaces":
- analytics products generally produced on the analytics platform (also AP)
- data products generally produced on the data platform (also DP)
- both the AP an DP are split into two separate workspace environments (ie, coupled non-prod and prod workspaces):
  * products which use internal data and are served to internal customers
  * products which use internal and/or external client data and are served to external customers
  * AP and DP are both split into separate sets of workspaces to easily enable data segregation -- each individual workspace can have one or more associated data catalogs.  since catalog bindings work at the workspace level, to ensure external client data is not being served internally we can bind both internal and external catalogs to the EC workspaces while only binding internal catalogs to the IC workspaces.
  * this leads to a situation where there are a minimum of 12 required workspaces (deployment targets) within the ADE.  additionally, due to limitations with how databreaks releases new features there are additional POC/integration workspaces that are not technically required, but helpful -- these are annotated with asterisks:
    + internal analytics platform (IAP):
      + non-prod:
        + DEV, TEST, *MASKED-DEV, *POC (POC workspace shared with EAP)
      + prod:
        + PROD
    + external analytics platform (EAP):
      + non-prod:
        + DEV, TEST, *POC (POC workspace shared with IAP)
      + prod:
        + PROD
    + internal data platform (IDP):
      + non-prod:
        + DEV, TEST, *STAGING (STAGING workspaces shared with EDP)
      + prod:
        + PROD
    + external data platform (EDP):
      + non-prod:
        + DEV, TEST, *STAGING (STAGING workspaces shared with IDP)
      + prod:
        + PROD
    + enterprise account admin (used for auditing and governance)
      + non-prod:
        + *ENABLEMENT (new features and cross-platform enablement development)
      + prod:
        + *PROD (workspace activity monitoring and alerting, governance enforcement, cross-platform admin, etc)

an effective data ecosystem goes beyond just compute, however, a data ecosystem built on top of a databricks delta lake has very unique requirements for proper governance due to the unity catalog (UC) being a centralized account-level asset.

historically, all data would be segregated to it's own environment/deployment target -- which made it easy to safely segregate data but made data access more rigid and onerous.  within databricks, this segregation can be implemented effectively while *allowing* approved cross-platform/environment by using federated catalogs and workspace bindings.  one of the reasons we need *separate workspaces* for distinct platforms/deployment targets is that federated catalogs can only be bound at the workspace level -- meaning, if we want to ensure sensitive external production data does not end up in an internal product or a dev environment, we need a separate workspace we can bind to catalogs which contain the sensitive external data products too.

the problem becomes more complicated (but also simplified in some respects) by the fact data products and analytics products are built on orthogonal data planes.  what this means is that data product development happens on non-sensitive and non-prod data source and analytics product development must use sensitive, production data sources.  *all* analytics products start with production data; fake/synthetic data is not suitable for exploratory data analysis (EDA), feature development/engineering, model training, hyperparameter turning, reporting, etc.  when you promote an analytics product from non-prod to prod, you read from the *same* data (generally -- there can be *some* differences such as use masked/de-identified and/or sampled data in non-prod, but these are generally derived directly from the full prod data sources) and are deploying the code to run automatically in a segregated environment as a service account/principal.

compared to data engineering where it is the *structure* of the data, not the exact data values, which is important.  so long as the data being mocked shares the same structure such as data/column types, data format (hive, delta, parquet, json, protobuf, csv, etc), consumer access patterns/interfaces (read from managed table, stream from kafka topic, ingest new files in s3, etc), producer access patterns/interfaces (save as managed table, write to kafka topic, etc), and data volume/throughput.  data product development usually *starts* with an automated process run by/as a service account/principal, so promotion from non-prod to prod environments is generally an exercise in updating the input and output data sources of the process.

## analytics products vs data products
The AP vs DP distinction was made due to the vast differences between how analytics and data products are developed, deployed, governed, and interfaced with.  data analysis and data science operates under fundamentally different frameworks using fundamentally different tools and usage patterns than data engineering.

+ data engineering is *engineering*: it seeks to **create order from chaos** with reliable and consistent systems which ingest inconsistent data from varied sources and transform it into a single, consistent data product for reliable consumption of the data.
+ data science & analytics is an *art*: it seeks to **create meaning from material** by iteratively exploring and interacting with the data to derive meaningful patterns, descriptions, and relationships from the data.

+ data engineering is *engineering*: it creates **materials from madness** by building reliable and reproducible systems to transform varied and inconsistent data sources into consistent and coherent data products.
+ data science & analytics is an *art*: it creates **meaning from material** by iteratively exploring and interacting with the data to derive meaningful patterns, descriptions, and relationships from the data.


**data engineers** are **farmers**, turning sun, seed, and soil into flour and sugar.
**data scientists** are **chefs**, turning flour and sugar into bread and cake.
**analytics engineers** are **distributors**, turning bread and cake into packaged goods anyone can eat.

**data products** are the **ingredients**, **analytics products** are the **meals**.


| usage | data science/analytics | data engineering | analytics engineering |
|-------+------------------------+------------------+-----------------------|
| purpose | machine learning, predictive modeling, reporting, analysis | ETL, data curation, data serving | model serving, model monitoring/retraining, model scoring, feature engineering, feature store, feature importance/clinical insights |
| user workloads | interactive | automated | automated |
| user interaction | UI-oriented | code- & CI/CD-oriented | code- & CI/CD-oriented |
| primary user interface | notebooks, SQL editor, dashboards | jobs/workflows | jobs/workflows, dashboards |
| products | serialized models, notebooks, dashboard/report extracts | managed tables, views, data streams | model endpoints, feature store, data streams, managed fact/scoring tables (served as data product via DP/USM catalog) |
| data sharing | intra-team | both intra- and inter-team | intra-team and inter-team |
| data access | highly segregated | highly interdependent | mixed |
| primary user compute | all purpose clusters, SQL warehouses | job clusters, SQL warehouses | job clusters, SQL warehouses |

| Resources  | analysts/data scientists | data engineers | analytics engineers |
|------------+-----------------------+---------+--------------------------------------|
| workspaces | AP | DP | AP |
| inter-team data serving | no | team managed | no |
| inter-team data access | admin managed | team managed | admin managed |
| schema ownership | admin managed | team managed | admin managed |
| shared interactive clusters | admin managed | team managed | admin managed |
| single user interactive clusters | admin managed, team configurable | team managed | admin managed, team configurable |
| warehouses | admin managed | team managed | admin managed |
| job compute | admin managed | team managed | team managed |
| team compute pools | admin managed | team managed | admin and team managed |
| shared compute pools | no | admin managed | admin managed |
| non-pooled compute | admin managed | team managed | team managed |
