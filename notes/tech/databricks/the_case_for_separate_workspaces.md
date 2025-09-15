# the multi- vs unified workspace approach to databricks
## executive summary

## overview
currently within the evernorth databricks ecosystem, there are two primary distinctions:
1) Evernorth Health Services (EHS) vs Cigna Healthcare (CHC)
2) Analytics Products (EAP) vs Data Products (EDP)

## analytics products vs data products
The EAP vs EDP distinction was made due to the vast differences between how Analytics and Data Products are developed, operationalized, interfaced with, and governed.  Data analysis and data science operates under fundamentally different frameworks using fundamentally different tools and usage patterns than data engineering.

+ Data engineering is *engineering*: it seeks to **create order from chaos** with reliable and consistent systems which ingest inconsistent data from varied sources and transform it into a single, consistent data product for reliable consumption of the data.
+ Data science & analytics is an *art*: it seeks to **create meaning from material** by iteratively exploring and interacting with the data to derive meaningful patterns, descriptions, and relationships from the data.

+ Data engineering is *engineering*: it creates **materials from madness** by building reliable and reproduceable systems to transform varied and inconsistent data sources into consistent and coherent data products.
+ Data science & analytics is an *art*: it creates **meaning from material** by iteratively exploring and interacting with the data to derive meaningful patterns, descriptions, and relationships from the data.


Data Engineers are farmers, turning sun, seed, and soil into flour and sugar.
Data Scientists are chefs, turning flour and sugar into bread and cake.
Analytics Engineers are distributors, turning bread and cake into packaged goods anyone can eat.

Data Products are the ingredients, Analytics Products are the meals.


| usage | data science/analytics | data engineering | analytics engineering |
|-------+------------------------+------------------+-----------------------|
| purpose | machine learning, predictive modeling, reporting, analysis | ETL, data curation, data serving | model serving, model monitoring/retraining, model scoring, feature engineering, feature store, feature importance/clinical insights |
| user workloads | interactive | automated | automated |
| user interaction | UI-oriented | code- & CI/CD-oriented | code- & CI/CD-oriented |
| primary user interface | notebooks, SQL editor, dashboards | jobs/workflows | jobs/workflows, dashboards |
| products | serialized models, notebooks, dashboard/report extracts | managed tables, views, data streams | model endpoints, feature store, data streams, managed fact/scoring tables (served as data product via EDP/USM catalog) |
| data sharing | intra-team | both intra- and inter-team | intra-team and inter-team |
| data access | highly segregated | highly interdependent | mixed |
| primary user compute | all purpose clusters, SQL warehouses | job clusters, SQL warehouses | job clusters, SQL warehouses |

| Resources  | EAP Analytics Teams | EDP Teams | SAE/POPs Teams (Analytics Engineers) |
|------------+-----------------------+---------+--------------------------------------|
| workspaces | EAP (CHC & EHS) | EDP | EAP (CHC & EHS) |
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

