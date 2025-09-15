# references
- [databricks audit system table reference](./databricks/atabricks-system_table-audit-ref.csv)
  * contains audit log reference table for `service_name` and `action_name` filters
  * [also available as a markdownfile](./databricks/databricks-system_table-audit-ref.md)
- [simplified aws ec2 instances info table for us-east-1](./aws/aws-ec2-us_east_1-simple.csv)
  * [larger reference table with additional columns and all us-east-* regions](./aws/aws-ec2-us_east-extra.csv)
  * [full reference table with all columns and all locations (this ish is big and annoying to use)](./aws/aws-ec2-ref.csv)
  * [smaller table for us-east-1 with additional ratio metrics](./aws/aws-ec2-us_east_1-simple_metrics.csv)
- [databricks scim api docs](./databricks/databricks-scim_api-v2.1.md)

# query with sqlite3
i use the below bash function to query these big csvs to easily find what i want:
```bash
csq() {
    # the first parameter is the csv to query, second is the query itself
    # refer to the csv as _ in the query
    sqlite3 "" ".headers on" ".separator ," ".mode csv" ".import $1 _" "$2"
}
```
an example for how to use:
```bash
# show all instances by ratio between cpu clock speed and on-demand pricing
csq aws-ec2-us_east_1-simple_metrics.csv "select * from _ order by comp_price_ratio"
```
for an even better experience, install [xsv](https://github.com/BurntSushi/xsv) and read it right from the terminal:
```bash
# show all "general purpose" instances with "large" size and show with xsv
> csq aws-ec2-us_east_1-simple.csv " \
  select instanceType, vCpus, processorClockSpeedInGhz, spotLinuxHr, onDemandLinuxHr \
  from _ \
  where instanceFamilyName = 'General purpose' \
  and instanceType like '%.large' \
" | xsv table


instanceType    vCpus  processorClockSpeedInGhz  spotLinuxHr  onDemandLinuxHr
a1.large        2.0    2.3                       0.0508       0.051
m1.large        2.0    0.0                       0.0361       0.175
m3.large        2.0    2.5                       0.0322       0.133
m4.large        2.0    2.4                       0.0328       0.1
m5.large        2.0    3.1                       0.0294       0.096
m5a.large       2.0    2.5                       0.0295       0.086
m5ad.large      2.0    2.2                       0.0416       0.103
m5d.large       2.0    3.1                       0.04         0.113
m5dn.large      2.0    3.1                       0.0392       0.136
m5n.large       2.0    3.1                       0.0447       0.119
m5zn.large      2.0    4.5                       0.045        0.1652
m6a.large       2.0    3.6                       0.0289       0.0864
m6g.large       2.0    2.5                       0.0208       0.077
m6gd.large      2.0    2.5                       0.027        0.0904
m6i.large       2.0    3.5                       0.0272       0.096
m6id.large      2.0    3.5                       0.0343       0.1187
m6idn.large     2.0    3.5                       0.0445       0.1591
m6in.large      2.0    3.5                       0.0438       0.1392
m7a.large       2.0    3.7                       0.0337       0.1159
m7g.large       2.0    2.6                       0.0268       0.0816
m7gd.large      2.0    2.6                       0.0329       0.1068
m7i-flex.large  2.0    3.2                       0.0224       0.0958
m7i.large       2.0    3.2                       0.0296       0.1008
m8g.large       2.0    2.8                       0.0281       0.0898
t2.large        2.0    2.3                       0.0239       0.0928
t3.large        2.0    2.5                       0.0274       0.0832
t3a.large       2.0    2.2                       0.0218       0.0752
t4g.large       2.0    2.5                       0.0096       0.0672
```
