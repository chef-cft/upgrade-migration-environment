# Chef Server
output "chef_server-public_ipv4" {
  value = "${digitalocean_droplet.chef-server.ipv4_address}"
}

output "chef_server-private_ipv4" {
  value = "${digitalocean_droplet.chef-server.ipv4_address_private}"
}
