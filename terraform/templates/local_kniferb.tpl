current_dir = File.dirname(__FILE__)
client_key "#{current_dir}/${chef_user_id}.pem"
node_name '${chef_user_id}'
ssl_verify_mode :verify_none
chef_server_url 'https://${chef_server_hostname}/organizations/${chef_org_shortname}'
