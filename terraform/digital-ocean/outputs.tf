# Chef Server
output "download_chef_server_credentials" {
  value = "scp root@${digitalocean_droplet.chef-server.ipv4_address}:'/tmp/*.pem /tmp/config.rb' .chef/"
}
