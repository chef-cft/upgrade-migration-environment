client_key '~/.chef/${chef_user_id}.pem'
validation_client_name '${chef_org_shortname}-validator'
validation_key '~/.chef/${chef_org_shortname}-validator.pem'
ssl_verify_mode :verify_none
node_name '${chef_user_id}'
