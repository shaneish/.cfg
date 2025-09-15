# DATABRICKS SYSTEM TABLE GOVERNANCE
---
## CONTEXT
### IMPORTANCE OF SYSTEM TABLES FOR WORKSPACE ADMINISTRATION
Real time access to system tables are incredibly important for workspace administration, monitoring, auditing, and governance.  Almost any event or service we'd like to manage in Databricks has a presence in the system tables -- and for some, like data lineage, the system tables are the only way to access the information.  For others, such as compute, the system tables are by far the most efficient way to do so and do not eat at our API limits.

### CURRENT ISSUES
A big issue with the current system table approach is that *everyone* has unfettered access to system tables, which is not in line with best practices or good governance.  Every user and admin team should have the minimal effective access to system tables required to do their jobs and nothing more.  For admins, that means only system table data in their workspaces.  For end users, that means only system table data for themselves and (potentially) their teams.

One key thing to keep in mind about the *system "tables" is that they are not actually tables, they are delta shares* coming into our workspace from Databricks.  This is why Databricks is concerned with our system table usage -- *teams who are accessing the system tables as if they're normal tables for dashboarding purposes are creating huge costs for Databricks*.  The appropriate way to interact with system tables programmatically is almost always to set up a Spark structured streaming job on the system tables to process information as it is shared our workspaces.  Anything other than this is massively inefficient.

### WORKSPACE ADMININISTRATION REQUIREMENTS
The system tables provide limitless potential for governance, monitoring, and auditing to workspace admin teams and loss of real time access via intermediate sources (such as daily dumps) would cripple existing and future workspace management.  To provide examples, without direct access to system tables for workspace admins, workspace admin teams would have no way to:
- **Govern scratch schemas -** we need to be able to monitor data lineage table in order to determine if all members of a scratch schema have appropriate data access to view a table created in a scratch schema.  This is particularly dependent on system tables as Databricks does not currently provide an API endpoint for data lineage information.
- **Monitor and govern clusters -** in order to enforce limits on total clusters and compute a team has up at one time, we need system tables to monitor when a new cluster is turned on so we can compare to other up clusters and ensure teams aren't spinning up more compute than appropriate.
- **Monitor and govern jobs -** in order to ensure new user-created jobs match our standards for non-pipeline production jobs, we need to be able to monitor job creation so we can enforce governance as jobs are created.
- **Automated user onboarding -** we currently use an Okta inline hook to automatically manage user access and resources (such as mapping global groups to user groups, removing user group access when global groups are removed, creating personal scratch schemas, reactivate deactivated users, etc) when they login to Databricks via SSO.  However, this process is cumbersome, inefficient, and incompatible with the future direction of moving all Databricks workspaces in the Evernorth Databricks account to a unified SSO process.  The most viable alternative to our inline SSO hooks is to monitor system tables for user logins to trigger onboarding actions within Databricks jobs instead -- which requires a real time feed from the audit system tables.
- **Effective collection of catalog information -** the most efficient way to catalog our UC catalogs in real time and ensure we're capturing and dashboarding information about our schemas and volumes is to stream catalog events from the system table and capture information about table/file size as they're created.  The only other alternative is to iterate over all schemas in our catalog and capture information in batches, which is massively inefficient.
- **Real time dashboarding and usage monitoring -** real time system table access needed in order to detect abusive resource usage and remediate immediately.  If a team manages to create a cluster/job/DLT pipeline that consumes unreasonable amount of compute or storage, we need to be able to detect that as it happens.  Example of this that we've come across so far have been a team spinning up multiple single user clusters at one time to run the same code with slight variations (hyperparameter tuning) and a team running a notebook that was generating and dumping 700+ GBs of CSVs into a volume in their scratch schema.  Controls have been implemented to prevent these specific issues in the future, but it's impossible for us to have complete certainty that similar situations aren't possible and without real time monitoring we wouldn't be able to catch it until it's too late.
---
## RECOMMENDATIONS
### BEST PRACTICES FOR SYSTEM TABLE USE
If we (or any of our users) want to collect historical system table data, we do not want to do so with traditional queries in a batch process.  The only appropriate way to do this is to set up Spark structured streaming jobs which monitor the system tables and write a stream to a table within our UC as new records come in.

We do not want to restrict access to system tables that blocks all uses except for structured streaming jobs, however, as being able to run ad-hoc queries against the "tables" is frequently necessary for admin teams to troubleshoot/debug issues and audit events, but all automated processes accessing system table data directly should be done via a streaming interface of some sort.  That could be a streaming job which does nothing more than create a local system table layer within our UC for use by automated processes (like dashboarding) or a streaming job which takes system table data and uses it immediately for other governance processes.

Even ad-hoc querying by admins should be done carefully to prevent resource abuse.  In most cases where an admin needs to query the tables to troubleshoot an issue or audit user activity, it's best to use a broader query that captures all potentially relevant information at one time and stores the output into a new table for further analysis.

### GOVERNANCE FOR WORKSPACE ADMINISTRATOR USE
In order to address these concerns while still ensuring admins have enough access to govern workspaces, my primary suggestion would be to build views on top of each system table filtered by workspace ID and only grant access to those tables to the adminstrators of those workspaces.  This will ensure admins cannot view data about other workspaces while maintaining real time access to tables for their own workspace.  Additionally, we should encourage admins to use structured streaming jobs for all automated admin processes.
```sql
  ┌───────────────────────────────┐
   **Audit System Table**
   Location: `system.access.audit`
   Columns:
   - account_id
   - workspace_id
   - version
   - ... (other columns)
  └───────────────────────────────┘
   │ │
   │ │  ┌─────────────────────────────────────────────────────────────────────────┐
   │ │   **CHC EAP Admin Audit System Table View**
   │ │   Location: `platform.chc_eap.access__audit`
   │ └─► View definition:
   │       CREATE VIEW IF NOT EXISTS platform.chc_eap.access__audit
   │       AS SELECT * FROM system.access.auditing
   │       WHERE workspace_id in ("234172798029718", "149802285607479", "922310190196067")
   │    └─────────────────────────────────────────────────────────────────────────┘
   │
   │    ┌─────────────────────────────────────────────────────────────────────────┐
   │     **EHS EAP Admin Audit System Table View**
   │     Location: `platform.ehs_eap.access__audit`
   │     View definition:
   └──►    CREATE VIEW IF NOT EXISTS platform.ehs_eap.access__audit
           AS SELECT * FROM system.access.auditing
           WHERE workspace_id in ("2526242183754071", "903937390948931", "5629214838322243")
        └─────────────────────────────────────────────────────────────────────────┘
```
### GOVERNANCE FOR END USERS AND NON-ADMIN TEAMS
For non-admin users who may need access to system table information for dashboarding purposes, the primary suggestion is to leave that access and governance to the workspace administrators.  We do not want to allow end users to directly query the system tables or the workspace views on the system tables as they are likely to not follow best practices and stream from the system tables.

Additionally, we do not want our end users to be able to access system data for other teams.  Given the disparate team systems and team governance processes within each set of workspaces, it makes more sense for all non-admin users to be completely blocked from system table and direct system table views from an account perspective and allow workspace admin teams to enable the minimally effective access to system table data for the teams they support via views on local system table layers.

Instead of allowing end users to query the system tables directly, each admin team should use structured streaming jobs to create a local copy of the relevant system table information within our local UC catalogs.  On top of this local system table layer, workspace admins should build views which filter the data so that only events tied to that user, that user's team members, and any resources that user has access to are visible to the user querying the tables.
```sql
┌──────────────────────────────────────────────────────────────────────────────────┐
           Admin system table access process enabled by account admins
  ┌───────────────────────────────┐
   **Cluster System Table**
   Location: `system.compute.clusters`
   Columns:
   - account_id
   - workspace_id
   - version
   - ... (other columns)
  └───────────────────────────────┘
               │
               ▼
  ┌──────────────────────────────────────────────────────────────────────────┐
   **CHC EAP Admin Cluster System Table View**
   Location: `platform.chc_eap.compute__clusters`
   View definition:
     CREATE VIEW IF NOT EXISTS platform.chc_eap.compute__clusters
     AS SELECT * FROM system.compute.clusters
     WHERE workspace_id in ("234172798029718", "149802285607479", "922310190196067")
  └──────────────────────────────────────────────────────────────────────────┘
└──────────────┼───────────────────────────────────────────────────────────────────┘
               │
               │
               │
               │
   Workspace admin enablement for downstream teams
               │
               │
               │
               │
               ▼
┌──────────────────────────────────────────────────────────────────────────────────┐
         User system table access enabeld by workspace admins
  ┌───────────────────────────────────────────────────────────────────┐
  │**Spark Streaming Job**                                            │
  │Purpose: Create system table layer in internal UC platform catalog.│
  │Read stream from: `platform.chc_eap.compute__clusters`             │
  │Write stream to: `platform.chc_eap.compute__clusters__local`       │
  └───────────────────────────────────────────────────────────────────┘
               │
               ▼
  ┌─────────────────────────────────────────────────────┐
   **Local CHC EAP Admin Cluster Layer**
   Location: `platform.chc_eap.compute__clusters__local`
  └─────────────────────────────────────────────────────┘
               │
               │
   Views created on local UC system table layer for each team that requires it
               │
               │
               ▼
  ┌─────────────────────────────────────────────────────────────────────┐
   **CMG_EAP_PRODENG Cluster System Table View**
   Location: `chc_eap_prod.prodeng_work.compute__clusters`
   View definition:
     CREATE VIEW IF NOT EXISTS chc_eap_prod.prodeng_work.compute__clusters
     AS SELECT * FROM platform.chc_eap.compute__clusters
     WHERE tags.Team = 'CMG_EAP_PRODENG'
  └─────────────────────────────────────────────────────────────────────┘
└───────────────────────────────────────────────────────────────────────────────────┘
```
