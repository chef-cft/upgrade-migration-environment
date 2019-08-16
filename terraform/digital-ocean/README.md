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

4. Run terraform commands.
```
$ terraform init
$ terraform validate
$ terraform plan
$ terraform apply
```

5. After the terraform applies successfully it outputs an SCP command to download the credentials to communicate with the chef-server. The command should be copied and run from your terminal and looks something like this:
```shell
$ scp root@CHEFSERVERIPADDRESS:"/tmp/*.pem /tmp/config.rb" .chef/
```

6. Now knife commands that communicate with the Chef Server should work.
```
$ knife ssl fetch
$ knife client list
```
