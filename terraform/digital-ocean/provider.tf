provider "digitalocean" {
    token = "${var.do_api_token}"
}

terraform {
  required_version = "> 0.12.0"
}
