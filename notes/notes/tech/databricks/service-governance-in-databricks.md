# Governance in Databricks

---
## Context
There are a number of governance holes in Databricks that need to be addressed, at both the account/metastore level and the workspace level.  There are ways we can engineer retroactive controls on data, resources, and services, but no way to proactively block unauthorized actions.  The intent of this document is to document these shortcomings, provide suggestions/feature requests for Databricks to help remediate these shortcomings, and describe current best practices for remediating these shortcomings internally until given an official solution from Databricks.

## Descriptions
*Workspace-level Service Governance*: Databricks enables all users access to multiple services in the workspace (such as workflows, DLT pipelines, model serving endpoints, etc) by default and provides no way to govern who can use each service or even *how* they can use each service.  When it comes to cluster configuration, Databricks provides us with the ability to create cluster policies that can dictate *exactly* how our users can create clusters -- but provide us with nothing similar for workspace resources and services in general.

*Metastore-level Data Governance*: The way grants and permissions are propagated and inherited in the UC leaves open a number of data access and governance holes.  Specifically, grants to access tables, views, and schemas are propagated down the metastore organization -- which means that permissions on tables inherit from permissions on schemas, which inherit from permissions on catalogs, etc all the way up the chain.  The problem with this is that the process of creating new tables from existing tables doesn't happen within this metastore permissions hierarchy, so that permissions/grants on derivative tables can have completely separate permissions/grants than the parent tables they derive from.  This has a number of security implications, not least of which the ability for users with read access to tables to sidestep data owner approvals and share data with users who don't have the necessary permissions by simply creating a new table from the parent table.  Permissions/grants on tables *need* to be propagated via data lineage -- not metastore hierarchy.

*Workspace-level Resource Governance:* For general workspace-level resources, Databricks makes no distinction between managing resource permissions and managing the resource configuration itself.  Within Databricks, if we give a user/team the ability to manage their resource configuration (such as shared clusters, warehouses, dashboards, etc), then those users/teams can then give *any* other workspace principal (user, team, SP) both use and manage permissions on that resource.  This makes resource management a headache, because we cannot ensure that our users are not giving other users/teams access to any resources that they shouldn't have access to without leaving the workspace admins in a position where they must manage the configuration of those resources themselves.  Specifically, if we want to allow teams to update their shared clusters within the bounds of a cluster policy, then those teams will also be able to give other teams the ability to use that cluster -- however, if we revoke that ability then teams will require workspace admins to make every small update to their existing clusters when needed.

---
## Workspace-level services
We need some ability to constrain how our workspace users can use the various services Databricks offers, such as workflows, DLT pipelines, vector indexes, model serving, dashboards, etc.  At a minimum, we need the ability to enable/disable these services for specific sets of users (or all users), but ideally we need the ability to allow use of these services in a constrained way that controls exactly how they can be configured by users.

### Long term solution
*Feature request with Databricks to allow policy creation for services:*

The feature we'd like to request from Databricks to govern service use within our workspaces is the ability to create service policies for each set of services offered in the workspaces.  These service policies should work exactly like cluster policies do for clusters: allowing us to craft policies assignable to workspace principals (users, teams, SPs) that specify the exact allowable values the principal using that policy is allowed to select when using the service to create a workspace resource.  These policies should use the same Databricks Configuration Language that cluster policies use.

To give a specific example for what these policies would look like and how they'd be used, please reference the [Policies for Workspace Resources & Services](governance-policies_for_databricks_services.md) document I've created.  This document details how appropriate governance can be build on functionality from the Databricks API and gives example Databricks Configuration Language snippets for how provisioning and usage of resources/services could be controlled *prior* to any action being taken within our workspaces.

With service policies in place, we'd be able to proactively prevent users from taking any actions that we prohibit.

### Short term solution
*Service monitoring and controls via system table structured streaming jobs created by internal engineers:*

To implement governance and controls on how our users interact with Databricks services in the near term, the primary suggestion is to use a Spark streaming job to monitor the appropriate system table for when a given service is used to create or update a resource, check the configuration of the resource that has been created/updated, validate whether it is an allowable or prohibited resource, and then use the Databricks API to either update the resource or delete it (where appropriate).  As system tables are updated in real time, a Spark job which streams from the appropriate system table will be able to immediately see if a change has been made using a relevant service and trigger a custom governance function created by internal engineering teams.

For example, if a user creates a production workflow in the UI with a recurring schedule (rather than via a governed CI/CD process), a new record will immediately show in the `system.access.audit` system table with `service` column set to `'jobs'` and `action` column set to `'create'` or `'update'` (please see the [audit log reference documentation](https://docs.databricks.com/en/admin/account-settings/audit-logs.html#job-events) for additional services and/or actions support).  Our Spark streaming job will then use the job metadata provided in the same row to check the workflow configuration via Databricks API.  Then, if the workflow was created with a recurring schedule by a non-admin SP, the streaming job will make an additional Databricks API call to edit the workflow and remove the recurring schedule.  For additional examples, please see [this doc](./governance-policies_for_databricks_services.md) I put together on system table governance.

The process described above can be extended to practically every service and/or resource within our Databricks workspaces -- as long as there's a system table that tracks it, we can govern it.  However, there are a number of shortcomings with this approach that make it less ideal than the service policy feature request described above:
1) Governance is retroactive rather than proactive.  This means that we cannot prevent users from trying to create a prohibited resource.  However, as system tables are updated in real time, we can ensure that prohibited resources are detected and dealt with in a reasonable short time period (2 mins or less in 80% of situations, from my testing).
2) Governance is built on resources that we must pay for.  Spark streaming jobs take engineering time to implement and run on compute within Databricks that we must pay for.  In most cases the compute costs will be minimal -- especially compared to potential governance failures -- but the costs are still greater than simply prohibiting creation at all.

Specifically with regards to the approach being retroactive, we can mitigate this somewhat by also using the system tables to log access/use of prohibited resources between the time of creation and the time we mitigate them.  Again, this isn't as good as completely blocking it, but we will at least know exactly who did it and hold them accountable.

---
## Metastore-level data access controls
Within our centralized metastore, we need a way to ensure that users aren't sidestepping the approval of data owners to give others access to data they lack the appropriate global groups for.  One big issue with data governance in Databricks is that if you query a table and use it to create a new table, the new derivative table has none of the permissions/grants of the parent table and the derivative table is now owned by whoever created the table -- not whoever owned the table(s) it was created from.  So, if you want to give someone access to data that they don't have the necessary global groups for, all you need to do is run:
```sql
CREATE TABLE different_catalog.scratch_schema.example_table_copy AS (SELECT * FROM source_catalog.whatever_pubz.example_table)
```
to create a new table in a location that person *does* have read access to (`different_catalog.scratch_schema` in the example given) and suddenly that person can see everything in that table without having the requisite global groups!

In Databricks, access to data resources are propagated down the metastore hierarchy and not by data lineage.  This means that if access to a given table is determined by the permissions on the schema and catalog it's in (in addition to the table-specific permissions), rather than permissions on the catalogs, schemas, and tables of the tables used to create it.  To rectify this, we need data access propagated via data lineage so that the permissions on a table are determined by the most restrictive permissions a principal (user, team, SP) has on *all* parent tables used to create the table -- unless it's a source table without an parent tables within the UC, of course.

### Long term solution
*Feature request with Databricks to configure how data permissions are propagated for metastore assets:*

For this feature, we want to be able to specify how permissions are determined for derivate metastore assets.  We'd need the ability to specify or mark which assets should have data lineage-based permission inheritance set for derivate data assets, such as via tags or a table/schema/catalog/volume-level setting that can be granted, and once we've specified which metastore assets should be restricted to data lineage then Databricks should update permissions on a given data asset at the time of creation -- which is simply the intersection of all `SELECT` permissions on each parent table.  Propagating `EDITOR` permissions can be done a number of ways, but in my opinion the most straightforward is to only allow the asset owner of the derivative asset the ability to edit and/or grant others the ability to edit -- but really, so long as someone cannot edit a table without `SELECT` permissions then the security aspect of data governance is addressed.

It's important to note that this should apply to all relevant data assets, not just tables.  Specifically, access to files in volumes should also be subject to lineage-based permission inheritance -- otherwise bad actors would be able to get around the restrictions by simply saving a CSV to a volume instead of as another table.

### Short term solution
<code style="color : red">**TODO**</code>

**Service monitoring and controls via system table structured streaming jobs created by internal engineers:**

Data governance can be implemented with retroactive access controls using the same exact approach as service governance.  Specifically, a Spark streaming job should be configured to read a stream from the `system.access.table_lineage` system table.  When a change to a monitored location is detected in the lineage system table, permissions for all parent tables will be pulled and the intersection of parent table permissions calculated and applied to the new/updated table.

...

### Alternate short term solution
<code style="color : red">**TODO**</code>

...

---
## Workspace-level resources
<code style="color : red">**TODO**</code>

...

### Long term solution
<code style="color : red">**TODO**</code>

...

### Short term solution
<code style="color : red">**TODO**</code>

...
