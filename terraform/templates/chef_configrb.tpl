current_dir = File.dirname(__FILE__)
client_key "#{current_dir}/${chef_user_id}.pem"
validation_client_name '${chef_org_shortname}-validator'
validation_key "#{current_dir}/${chef_org_shortname}-validator.pem"
ssl_verify_mode :verify_none
node_name '${chef_user_id}'
