#!/bin/bash

set -e

yum install wget -y
cd /tmp && wget https://packages.chef.io/files/stable/chef-server/13.0.17/el/7/chef-server-core-13.0.17-1.el7.x86_64.rpm
rpm -Uvh /tmp/chef-server-core-13.0.17-1.el7.x86_64.rpm
chef-server-ctl reconfigure --chef-license=accept
chef-server-ctl user-create ${chef_user_id} ${chef_user_name} ${chef_user_email} ${chef_user_password} --filename /tmp/${chef_user_id}.pem
chef-server-ctl org-create ${chef_org_shortname} "${chef_org_longname}" --association_user ${chef_user_id} --filename /tmp/${chef_org_shortname}-validator.pem
chef-server-ctl reconfigure
echo "nginx[\"enable_non_ssl\"] = true" > /etc/opscode/chef-server.rb
chef-server-ctl reconfigure
echo "Finished"
