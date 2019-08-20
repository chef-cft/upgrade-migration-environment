name "base"
description "Baseline configuration for all systems."

run_list(
  "recipe[resolver]",
  "recipe[pam]",
  "recipe[ntp]",
  "recipe[yum]",
  "recipe[sysctl]",
  "recipe[sensu]",
  "recipe[chef-splunk]"
)

default_attributes(
  "resolver" => {
    "nameservers" => ["10.1.1.3", "10.1.1.4"],
    "search" => "int.example.com"
  },
  "ntp" => {
    "servers" => ["time.int.example.com"]
  }
)
