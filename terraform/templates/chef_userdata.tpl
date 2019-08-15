#cloud-config

bootcmd:
 - hostname chef-server.${domain_name}
 - echo 127.0.1.1 chef chef-server.${domain_name} >> /etc/hosts
 - echo chef-server.${domain_name} > /etc/hostname

preserve_hostname: true
