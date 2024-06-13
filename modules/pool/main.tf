terraform {
  required_version = ">= 1.8.0"
  required_providers {
    libvirt = {
      source  = "local/dmacvicar/libvirt"
      version = "0.7.6"
    }
  }
}

resource "libvirt_pool" "kvm_storage_pool" {
  name = "default"
  type = "dir"
  path = "/data/images"

  lifecycle {
    prevent_destroy = true
  }
}

output "pool_name" {
  value = libvirt_pool.kvm_storage_pool.name
}
