## 变量 libvirt 访问地址，如果非本地需要设置免密
variable "libvirt_uri" {
  description = "The URI for the libvirt provider"
  type        = string
  default     = "qemu:///system"
}

## 存储变量
variable "libvirt_volume" {
  description = "Configuration for libvirt volume"
  type = object({
    name   = string
    source = string
    format = string
  })
}

## 虚机相关变量
variable "libvirt_domain" {
  description = "Configuration for libvirt domain"
  type = object({
    name   = string
    memory = number
    vcpu   = number
    type   = string
  })
}
