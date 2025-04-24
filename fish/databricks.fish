# add cli completions
databricks completion fish | source

# all the abbrv
abbr -a dx databricks
abbr -a dxapi databricks api
abbr -a dxa databricks auth
abbr -a dxb databricks bundle
abbr -a dxcats databricks catalogs
abbr -a dxcp databricks cluster-policies
abbr -a dxc databricks clusters
abbr -a dxcl databricks clusters
abbr -a dxconns databricks connections
abbr -a dxfs databricks fs
abbr -a dxinit databricks global-init-scripts
abbr -a dxgrants databricks grants
abbr -a dxg databricks groups
abbr -a dxgr databricks groups
abbr -a dxip databricks instance-pools
abbr -a dxj databricks jobs
abbr -a dxm databricks metastores
abbr -a dxms databricks metastores
abbr -a dxperms databricks permissions
abbr -a dxprm databricks permissions
abbr -a dxpi databricks pipelines
abbr -a dxpipe databricks pipelines
abbr -a dxpl databricks pipelines
abbr -a dxq databricks queries
abbr -a dxqh databricks query-history
abbr -a dxsc databricks schemas
abbr -a dxse databricks secrets
abbr -a dxsp databricks service-principals
abbr -a dxset databricks settings
abbr -a dxs databricks sync
abbr -a dxss databricks system-schemas
abbr -a dxtbl databricks tables
abbr -a dxtb databricks tables
abbr -a dxtkm databricks token-management
abbr -a dxtk databricks tokens
abbr -a dxu databricks users
abbr -a dxv databricks volumes
abbr -a dxwh databricks warehouses
abbr -a dxw databricks workspace
abbr -a dxwc workspace-conf

alias dxp="databricks auth profiles | grep -E '(YES|Valid)'"
