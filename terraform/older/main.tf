terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.5"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server   # 10.20.69.200 (vCenter)
  allow_unverified_ssl = true
}

# Datacenter
data "vsphere_datacenter" "dc" {
  name = "DCDevops"
}

# Cluster
data "vsphere_compute_cluster" "cluster" {
  name          = "ClusterDevops"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Datastore
data "vsphere_datastore" "ds" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Réseau / Portgroup
data "vsphere_network" "vm_net" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "lab_ubuntu_2404" {
  name             = "lab-ubuntu-2404"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id

  num_cpus = 2
  memory   = 4096
  guest_id = "ubuntu64Guest"

  firmware = "efi"

  network_interface {
    network_id   = data.vsphere_network.vm_net.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    size             = 40
    eagerly_scrub    = false
    thin_provisioned = true
  }

  cdrom {
    datastore_id = data.vsphere_datastore.ds.id
    path         = "iso/ubuntu-24.04.3-live-server-amd64.iso"
  }

  boot_delay = 5000

  wait_for_guest_ip_timeout  = 0
  wait_for_guest_net_timeout = 0
}
