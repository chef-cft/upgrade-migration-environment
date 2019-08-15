# Provider Info
variable "do_api_token" {
  description = "The API token used to interact with the Digital Ocean account."
  default     = "nil"
}

# Provisioning Info
variable "public_key" {
  description = "Path to the public SSH key needed to access host."
  default     = "~/.ssh/id_rsa.pub"
}
variable "private_key" {
  description = "Path to the private SSH key needed to access host."
  default     = "~/.ssh/id_rsa"
}

# Chef Server
variable "domain_name" {
  description = "TLD to use."
  default     = "some.tld"
}

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
