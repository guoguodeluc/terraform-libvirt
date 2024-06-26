## 使用模块创建网络
module "kvm_network" {
  source = "./modules/network"
}

## 使用模块创建存储池
module "kvm_storage_pool" {
  source = "./modules/pool"
}

## 通过本地qcow2镜像创建新的镜像卷
resource "libvirt_volume" "kvm_volume" {
  name   = var.libvirt_volume.name
  pool   = module.kvm_storage_pool.pool_name
  source = var.libvirt_volume.source
  format = var.libvirt_volume.format
}

## 创建虚机资源,设置console/graphics等
resource "libvirt_domain" "kvm_domain" {
  name   = var.libvirt_domain.name
  memory = var.libvirt_domain.memory
  vcpu   = var.libvirt_domain.vcpu
  type = var.libvirt_domain.type

  network_interface {
    network_id = module.kvm_network.network_id
  }

  disk {
    volume_id = libvirt_volume.kvm_volume.id
  }

  console {
    type        = "pty"
    target_port = "0"
  }

  graphics {
    type           = "vnc"
    listen_type    = "address"
    listen_address = "0.0.0.0"
  }

}

## 获取创建虚机的ip地址
data "external" "vm_ip" {
  depends_on = [libvirt_domain.kvm_domain]
  program = ["bash", "${path.module}/get_vm_ip.sh", var.libvirt_domain.name]
}
