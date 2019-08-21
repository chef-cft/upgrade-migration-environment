variable "chef_server_instance_cpus" {
  default = 2
}

variable "chef_server_instance_ram_mb" {
  default     = 4096
  description = "RAM value in MB"
}

variable "vsphere_datacenter" {
  default = "Tierpoint"
}

variable "vsphere_datastore" {
  default = "vsanDatastore"
}

variable "vsphere_linux_sshkeyfile" {
  default     = "~/.ssh/vagrant"
  description = "Path to the vagrant insecure private key, download from https://github.com/hashicorp/vagrant/blob/master/keys/vagrant"
}

variable "vsphere_linux_sshuser" {
  default = "vagrant"
}

variable "vsphere_linux_template" {
  description = "RHEL7 or CentOS7 template"
  default     = "centos76-template"
}

variable "vsphere_network" {
  default = "VM Network"
}

variable "vsphere_resource_pool" {
  default = "effortless-migration"
}

variable "vsphere_server" {
  default = "administrator@success.chef.co"
}

variable "vsphere_user" {
  default = "administrator@success.chef.co"
}

variable "vsphere_password" {}

# Chef Server
variable "chef_user_id" {
  description = "Username of the first user on chef server to be created."
  default     = "chefmigration"
}

variable "chef_user_name" {
  description = "Firstname / Lastname of the first user to be created."
  default     = "Chef Migration"
}

variable "chef_user_password" {
  description = "Password of the first user to be created."
  default     = "1234SuperMigrator"
}

variable "chef_user_email" {
  description = "E-mail of the first user to be created."
  default     = "chef@migration.tld"
}

variable "chef_org_shortname" {
  description = "Short name of the Chef Organization to be created."
  default     = "chefmigration"
}

variable "chef_org_longname" {
  description = "Long name of the Chef Organization to be created."
  default     = "Chef Migration Org"
}
