# chef_userdata template
data "template_file" "chef_userdata" {
  template = "${file("../templates/chef_userdata.tpl")}"

  vars = {
    domain_name = "${var.domain_name}"
  }
}

# chef_bootstrap template
data "template_file" "chef_bootstrap" {
  template = "${file("../templates/chef_bootstrap.tpl")}"

  vars = {
    chef_user_id       = "${var.chef_user_id}"
    chef_user_name     = "${var.chef_user_name}"
    chef_user_password = "${var.chef_user_password}"
    chef_user_email    = "${var.chef_user_email}"
    chef_org_shortname = "${var.chef_org_shortname}"
    chef_org_longname  = "${var.chef_org_longname}"
  }
}

# chef_configrb template
data "template_file" "chef_configrb" {
  template = "${file("../templates/chef_configrb.tpl")}"

  vars = {
    chef_user_id       = "${var.chef_user_id}"
    chef_org_shortname = "${var.chef_org_shortname}"
  }
}

# Add SSH Key
resource "digitalocean_ssh_key" "user" {
  name       = "${var.chef_user_email}"
  public_key = "${file(var.public_key)}"
}

# Create Droplet
resource "digitalocean_droplet" "chef-server" {
  image  = "centos-7-x64"
  name   = "chef-server"
  private_networking = true
  region = "nyc3"
  size   = "s-4vcpu-8gb"
  ssh_keys = [
    "${digitalocean_ssh_key.user.fingerprint}"
  ]

  provisioner "file" {
    connection {
      host = "${self.ipv4_address}"
      user = "root"
      type = "ssh"
      private_key = "${file(var.private_key)}"
    }
    content     = "${data.template_file.chef_configrb.rendered}"
    destination = "/tmp/config.rb"
  }

  provisioner "remote-exec" {
    connection {
      host = "${self.ipv4_address}"
      user = "root"
      type = "ssh"
      private_key = "${file(var.private_key)}"
    }
    inline = [
      "echo '${data.template_file.chef_bootstrap.rendered}' > /tmp/bootstrap-chef-server.sh",
      "chmod +x /tmp/bootstrap-chef-server.sh",
      "sudo sh /tmp/bootstrap-chef-server.sh",
      "echo \"chef_server_url 'https://${self.ipv4_address}/organizations/${var.chef_org_shortname}'\" >> /tmp/config.rb"
    ]
  }
  user_data = "${data.template_file.chef_userdata.rendered}"
}
