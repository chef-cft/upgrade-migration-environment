# Chef Server Terraform for Digital Ocean

## Prerequisites
```shell
brew install terraform # install Terraform using homebrew
```

## Getting Started
1. Set your `do_api_token` environment variable to interact with Digital Ocean's API.
```shell
$ export TF_VAR_do_api_token=yourdigitaloceanapiwithoutquotes
```

2. Change into the `terraform/digital-ocean` directory.
```shell
$ cd ~/path/to/repo/upgrade-migration-environment/terraform/digital-ocean
```

3. Update `variables.tf` with the information used for provisioning.
```
$ vim variables.tf
```

4. Run terraform commands.
```
$ terraform init
$ terraform validate
$ terraform plan
$ terraform apply
```

5. After the terraform applies successfully, copy the keys and `config.rb` to your local workstation. You'll need to replace `chef_server-public_ipv4` with the public IP that is in the output of the terraform run.
```shell
$ scp root@chef_server-public_ipv4:"/tmp/*.pem /tmp/config.rb" .chef/
```

6. Knife commands!
```
$ cd ~/.chef
$ knife ssl fetch
$ knife client list
```

If all goes well, you're communicating with the Chef Server.
