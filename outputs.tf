output "vm_name" {
  value      = libvirt_domain.kvm_domain.name
}

output "vm_ip_address" {
  value = data.external.vm_ip.result.ip
}
