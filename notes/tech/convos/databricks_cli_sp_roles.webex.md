
---
**jeff:** How do I get myself added as servicePrincipal.user to a Service Principal?  Also, how do I find out who has what permissions on a Service Principal?
```
Error: Cannot bind the service principal provided in 'run_as' field  
(6f6f37c8-de9a-4b25-8dcb-30107364ac16) to the job.
```
---
**drea:** i don't know but I also want to know - like just to see which ggs/users are assigned to a SP

---
**me:** We no longer have account admin access directly, so you'll need to authenticate as the account admin SP and check/make changes via the CLI, SDK, or API

---
I use the CLI.  The commands you need to use are `get-rule-set` and `update-rule-set`:

```console
These APIs manage access rules on resources in an account. Currently, only
  grant rules are supported. A grant rule specifies a role assigned to a set of
  principals. A list of rules attached to a resource is called a rule set.

Usage:
  databricks account access-control [command]

Available Commands:
  get-assignable-roles-for-resource Get assignable roles for a resource.
  get-rule-set                      Get a rule set.
  update-rule-set                   Update a rule set.

Flags:
  -h, --help   help for access-control

Global Flags:
      --debug            enable debug logging
  -o, --output type      output type: text or json (default text)
  -p, --profile string   ~/.databrickscfg profile
  -t, --target string    bundle target to use (if applicable)

Use "databricks account access-control [command] --help" for more information about a command. 
```

---
It is not easy, took me like 45 mins of messing around the first time to get it done because you have to use the etag system to ensure consistency

---
This is an example of successful commands I've used to check the assignable roles and get the current rule set for an SP:

```console
# check assignably roles
databricks account access-control get-assignable-roles-for-resource accounts/%{DATABRICKS ACCOUNT NUM}%/servicePrincipals/e6c9a787-c67a-45f7-85a5-1f51ac3d7f48/ruleSets/default --profile ACCOUNT_SP

# get rule set
databricks account access-control get-rule-set accounts/%{DATABRICKS ACCOUNT NUM}%/servicePrincipals/e6c9a787-c67a-45f7-85a5-1f51ac3d7f48/ruleSets/default "ACi1L_0ASKQDAMQGCnkKZAoQU2VydmljZVByaW5jaXBhbBJQYWNjb3VudHMvZmE2MjYzNDMtYjA3My00NzVkLTg5OGYtYTZkNTg0MTY0OWYzL3NzLzI2MzE1MjM5MDYwNzIyNzgSCHJ1bGVTZXRzGAMgn5rpk84yAQDH0IUoAQAA" --profile ACCOUNT_SP 
```
Unfortunately I don't have a good one for assigning rule set because it required so much input I ended up configuring it in a json file in my `tmp` folder and using that for the specification:

```console
databricks account access-control update-rule-set --json /tmp/use_sp.json 
```

---
You'll need to use the SP UUID instead of the name as well, here's an example for how to get the UUID from the name with the CLI:

```console
databricks service-principals list --profile prod-admin | grep 'INFRA-ADMIN-SP' | awk '{print $2}'  
```

---
Drea here is an example for how to get the current roles assigned to an SP (in this case 'INFRA-ADMIN-SP' is the SP I'm looking for, `prod-admin` is my Databricks profile to auth with our account admin SP's OBO token into our prod workspace, and `ACCOUNT_SP` is my Databricks profile to auth into the Account API with that same OBO token):

```consol
databricks account access-control get-rule-set accounts/%{DATABRICKS ACCOUNT NUM}%/servicePrincipals/$(databricks service-principals list --profile prod-admin | grep 'INFRA-ADMIN-SP' | awk '{print $2}')/ruleSets/default '' --profile ACCOUNT_SP 
```
The difference between the `prod-admin` profile and my `ACCOUNT_SP` profile is that the `ACCOUNT_SP` profile uses the account console URL for host and authenticates via Oauth.  These are what the two profiles look like in my `~/.databrickscfg` file for comparison:

```toml
[prod-admin]
host       = https://en-sae-databricks-prod.cloud.databricks.com/
token      = dapi… # obviously cut out the full token value

[ACCOUNT_SP]
host          = https://accounts.cloud.databricks.com/
account_id    = %{DATABRICKS ACCOUNT NUM}%
client_id     = 5ec535e6-b7f7-445a-b48c-86c47cece0c3
client_secret = dose… # obviously cut out the full secret value 
```
All of the other values besides `token` and `client_secret` above are values you can use as well.

---
Drea this is what the output will look like when you run it successfully.  It will show every principal with `USE` and `MANAGE` roles on the SP:

```json
{
  "etag":"ACi1L_0ASJwDALQGCngKYwoQU2VydmljZVByaW5jaXBhbBJPYWNjb3VudHMvZmE2MjYzNDMtYjA3My00NzVkLTg5OGYtYTZkNTg0MTY0OWYzL3NzLzg4NzQyMjM0NDk3MjQxORIIcnVsZVNldHMYAyCV_MuN6zIBAMfQhSgBAAA=",
  "grant_rules": [
    {
      "principals": [
        "users/562756@id.glbcore.com",
        "groups/CMG_EAP_PRODENG"
      ],
      "role":"roles/servicePrincipal.manager"
    },
    {
      "principals": [
        "groups/CMG_EAP_PRODENG"
      ],
      "role":"roles/servicePrincipal.user"
    }
  ],
  "name":"accounts/fa626343-b073-475d-898f-a6d5841649f3/servicePrincipals/5ec535e6-b7f7-445a-b48c-86c47cece0c3/ruleSets/default"
} 
```
