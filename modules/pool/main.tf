## 模块内单独设置 provides
terraform {
  required_version = ">= 1.8.0"
  required_providers {
    libvirt = {
      source  = "local/dmacvicar/libvirt"
      version = "0.7.6"
    }
  }
}

## 创建存储池，prevent_destroy 防止被删除
resource "libvirt_pool" "kvm_storage_pool" {
  name = "default"
  type = "dir"
  path = "/data/images"

  lifecycle {
    prevent_destroy = true
  }
}

## 输出
output "pool_name" {
  value = libvirt_pool.kvm_storage_pool.name
}
