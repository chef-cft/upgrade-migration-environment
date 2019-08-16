current_dir = File.dirname(__FILE__)
client_key "#{current_dir}/chefmigration.pem"
validation_client_name 'chefmigration-validator'
validation_key "#{current_dir}/chefmigration-validator.pem"
ssl_verify_mode :verify_none
node_name 'chefmigration'
chef_server_url 'https://134.209.170.12/organizations/chefmigration'
