variable "vsphere_user" {}
variable "vsphere_password" { sensitive = true }
variable "vsphere_server" {}

variable "datacenter" {}
variable "cluster" {}
variable "datastore" {}
variable "network_name" {}

variable "template_name" {}
variable "vm_name" {}
variable "vm_cpu" { default = 2 }
variable "vm_memory" { default = 4096 }
variable "vm_disk_gb" { default = 20 }
