output "chef_server_ssh" {
  value = "${formatlist("ssh -i %s %s@%s", var.vsphere_linux_sshkeyfile, var.vsphere_linux_sshuser, vsphere_virtual_machine.chef_server.*.default_ip_address)}"
}
