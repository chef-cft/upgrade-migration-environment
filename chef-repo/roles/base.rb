name "base"
description "Baseline configuration for all systems."

run_list(
  "recipe[resolver]",
  "recipe[yum]",
  "recipe[ntp]",
  "recipe[sysctl]"
)

default_attributes(
  "resolver" => {
    "nameservers" => ["8.8.8.8", "8.8.4.4"],
    "search" => "success.chef.co"
  },
  "ntp" => {
    "servers" => ["time-a.nist.gov"]
  }
)
