## 输出虚机名称
output "vm_name" {
  value      = libvirt_domain.kvm_domain.name
}

## 输出虚拟机ip地址
output "vm_ip_address" {
  value = data.external.vm_ip.result.ip
}
