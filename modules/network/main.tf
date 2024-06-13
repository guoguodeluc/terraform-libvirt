terraform {
  required_version = ">= 1.8.0"
  required_providers {
    libvirt = {
      source  = "local/dmacvicar/libvirt"
      version = "0.7.6"
    }
  }
}

resource "libvirt_network" "kvm_network" {
  name      = "kvm_network"
  mode      = "nat"
  addresses = ["192.168.123.0/24"]
  autostart = "true"
  
  dns {
    enabled = true
    forwarders {
      address = "233.5.5.5"
    }
  }
  
  routes {
    cidr = "192.168.123.0/24"
    gateway = "192.168.123.1"
  }
  
  lifecycle {
    prevent_destroy = true
  }
}

output "network_id" {
  value = libvirt_network.kvm_network.id
}
