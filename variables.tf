variable "libvirt_uri" {
  description = "The URI for the libvirt provider"
  type        = string
  default     = "qemu:///system"
}

variable "libvirt_volume" {
  description = "Configuration for libvirt volume"
  type = object({
    name   = string
    source = string
    format = string
  })
}

variable "libvirt_domain" {
  description = "Configuration for libvirt domain"
  type = object({
    name   = string
    memory = number
    vcpu   = number
    type   = string
  })
}
