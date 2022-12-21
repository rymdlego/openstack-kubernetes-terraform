variable "openstack_password" {}
variable "openstack_username" {}
variable "openstack_tenant_id" {}
variable "openstack_auth_url" {}
variable "openstack_region" {}

variable "pub_ssh_key" {}

variable "resource_prefix" {
  type    = string
  default = "lab"
}

variable "network_cidr" {
  type    = string
  default = "172.24.48.0/24"
}

variable "network_cidr" {
  type    = string
  default = "172.24.48.0/24"
}

variable "dhcp_start" {
  type    = string
  default = "172.24.48.101"
}

variable "dhcp_end" {
  type    = string
  default = "172.24.48.200"
}

variable "virtual_ip" {
  type    = string
  default = "172.24.48.10"
}

variable "bastion_ip" {
  type    = string
  default = "172.24.48.5"
}

variable "controlplanes" {
  type = map(any)
  default = {
    "cp01" = {
      name       = "cp01"
      ip_address = "172.24.48.11"
    }
    "cp02" = {
      name       = "cp02"
      ip_address = "172.24.48.12"
    }
    "cp03" = {
      name       = "cp03"
      ip_address = "172.24.48.13"
    }
  }
}

variable "nodes" {
  type = map(any)
  default = {
    "node01" = {
      name       = "node01"
      ip_address = "172.24.48.21"
    }
    "node02" = {
      name       = "node02"
      ip_address = "172.24.48.22"
    }
    "node03" = {
      name       = "node03"
      ip_address = "172.24.48.23"
    }
  }
}

variable "network_name" {
  type    = string
  default = "network01"
}

variable "subnet_name" {
  type    = string
  default = "subnet01"
}

variable "router_name" {
  type    = string
  default = "router01"
}
