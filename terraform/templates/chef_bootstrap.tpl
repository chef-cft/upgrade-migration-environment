#!/bin/bash

set -e

# install chef-server
rpm -ivh https://packages.chef.io/files/stable/chef-server/12.1.2/el/7/chef-server-core-12.1.2-1.el7.x86_64.rpm

# configure chef-server
(
cat <<'EOF'
api_fqdn 'chef-server.success.chef.co'
nginx['enable_non_ssl'] = true
EOF
) > /etc/opscode/chef-server.rb

chef-server-ctl reconfigure # --chef-license=accept
chef-server-ctl user-create ${chef_user_id} ${chef_user_name} ${chef_user_email} ${chef_user_password} --filename /tmp/${chef_user_id}.pem
chef-server-ctl org-create ${chef_org_shortname} "${chef_org_longname}" --association_user ${chef_user_id} --filename /tmp/${chef_org_shortname}-validator.pem

# install manage
rpm -ivh https://packages.chef.io/files/stable/chef-manage/2.1.0/el/7/chef-manage-2.1.0-1.el7.x86_64.rpm
chef-manage-ctl reconfigure # old versions have no license to accept

echo "Finished"
