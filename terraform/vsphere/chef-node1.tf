resource "vsphere_virtual_machine" "chef_node1" {
  name             = "chef_node1"
  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"
  depends_on       = ["null_resource.chef_server_post"]
  num_cpus         = "${var.chef_server_instance_cpus}"
  memory           = "${var.chef_server_instance_ram_mb}"
  guest_id         = "${data.vsphere_virtual_machine.template.guest_id}"
  scsi_type        = "${data.vsphere_virtual_machine.template.scsi_type}"

  connection {
    type        = "ssh"
    user        = "${var.vsphere_linux_sshuser}"
    private_key = "${file("${var.vsphere_linux_sshkeyfile}")}"
  }

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  # OS disk (note, don't change the label: https://www.terraform.io/docs/providers/vsphere/r/virtual_machine.html#label)
  disk {
    label            = "disk0"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = false
    thin_provisioned = true
    unit_number      = 0
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
  }

  provisioner "chef" {
    attributes_json = <<EOF
      {
        "key": "value"
      }
    EOF

    run_list        = ["role[base]"]
    environment     = "_default"
    node_name       = "chef_node1"
    server_url      = "https://${vsphere_virtual_machine.chef_server.default_ip_address}/organizations/${var.chef_org_shortname}"
    recreate_client = true
    user_name       = "${var.chef_user_id}"
    user_key        = "${file("${path.module}/.chef/${var.chef_user_id}.pem")}"
    version         = "12.5.1"

    # If you have a self signed cert on your chef server change this to :verify_none
    ssl_verify_mode = ":verify_none"
  }
}
