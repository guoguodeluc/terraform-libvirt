## 使用本地缓存 provides ，并设置版本
terraform {
  required_version = ">= 1.8.0"

  required_providers {
    libvirt = {
      source  = "local/dmacvicar/libvirt"
      version = "0.7.6"
    }

    external = {
      source  = "local/hashicorp/external"
      version = "~> 2.0"
    }
  }
}

provider "libvirt" {
  uri = var.libvirt_uri
}
