# add cli completions
databricks completion fish | source

# all the abbrv
abbr -a dx databricks
abbr -a dxapi databricks api
abbr -a dxa databricks account
abbr -a dxas databricks account settings-v2
abbr -a dxag databricks account groups-v2
abbr -a dxas databricks account service-principals-v2
abbr -a dxasp databricks account service-principals-v2
abbr -a dxau databricks account users-v2
abbr -a dxai databricks account iam-v2
abbr -a dxac databricks account access-control
abbr -a dxau databricks auth
abbr -a dxauth databricks auth
abbr -a dxapp databricks apps
abbr -a dxapps databricks apps
abbr -a dxb databricks bundle
abbr -a dxbundle databricks bundle
abbr -a dxcats databricks catalogs
abbr -a dxcatalogs databricks catalogs
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

function _databricks_profile
    set -gx DATABRICKS_CONFIG_PROFILE $(databricks auth profiles | sed '1d' | fzf --tiebreak=begin | awk '{print $1}')
    echo "Using Databricks profile: $DATABRICKS_CONFIG_PROFILE"
end
abbr -a dp _databricks_profile
