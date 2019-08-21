data "template_file" "chef_bootstrap" {
  template = file("../templates/chef_bootstrap.tpl")

  vars = {
    chef_user_id       = var.chef_user_id
    chef_user_name     = var.chef_user_name
    chef_user_password = var.chef_user_password
    chef_user_email    = var.chef_user_email
    chef_org_shortname = var.chef_org_shortname
    chef_org_longname  = var.chef_org_longname
  }
}

data "template_file" "local_kniferb" {
  template = file("../templates/local_kniferb.tpl")

  vars = {
    chef_user_id         = var.chef_user_id
    chef_org_shortname   = var.chef_org_shortname
    chef_server_hostname = vsphere_virtual_machine.chef_server.default_ip_address
  }
}

resource "vsphere_virtual_machine" "chef_server" {
  name             = "chef-server"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus  = var.chef_server_instance_cpus
  memory    = var.chef_server_instance_ram_mb
  guest_id  = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  connection {
    host        = self.default_ip_address
    type        = "ssh"
    user        = var.vsphere_linux_sshuser
    private_key = file(var.vsphere_linux_sshkeyfile)
  }

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  # OS disk (note, don't change the label: https://www.terraform.io/docs/providers/vsphere/r/virtual_machine.html#label)
  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks[0].size
    eagerly_scrub    = false
    thin_provisioned = true
    unit_number      = 0
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  provisioner "file" {
    content     = data.template_file.chef_bootstrap.rendered
    destination = "/tmp/bootstrap-chef-server.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo -S bash -ex /tmp/bootstrap-chef-server.sh",
    ]
  }
}

resource "local_file" "knife_rb" {
  filename = "${path.module}/.chef/knife.rb"
  content  = data.template_file.local_kniferb.rendered
}

resource "null_resource" "chef_server_post" {
  # fetch user pem
  # fetch user pem
  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no -i ${var.vsphere_linux_sshkeyfile} ${var.vsphere_linux_sshuser}@${vsphere_virtual_machine.chef_server.default_ip_address}:/tmp/${var.chef_user_id}.pem ${path.module}/.chef/${var.chef_user_id}.pem"
  }

  # generate cookbook data
  # generate cookbook data
  provisioner "local-exec" {
    command = "berks install --berksfile=${path.module}/../../chef-repo/Berksfile"
  }

  provisioner "local-exec" {
    command = "berks upload --no-ssl-verify --berksfile=${path.module}/../../chef-repo/Berksfile"
  }

  provisioner "local-exec" {
    command = "knife role from file ${path.module}/../../chef-repo/roles/base.rb"
  }

  depends_on = [
    vsphere_virtual_machine.chef_server,
    local_file.knife_rb,
  ]
}

