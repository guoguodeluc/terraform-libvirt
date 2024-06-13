#!/bin/bash
# 设置 libvirt provider 的 URI，其他主机 "qemu+ssh://root@<IP>/system"
export TF_VAR_libvirt_uri="qemu:///system"

# 设置 libvirt volume 的变量
export TF_VAR_libvirt_volume='{
  name   = "my-vm.qcow2"
  source = "/data/images/linux_centos_7.9_x86_64_2009_vmm20230621.qcow2"
  format = "qcow2"
}'

# 设置 libvirt domain 的变量
export TF_VAR_libvirt_domain='{
  name   = "my-vm"
  memory = 2048
  vcpu   = 2
  type   = "kvm"
}'
