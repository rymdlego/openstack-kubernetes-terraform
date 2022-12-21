terraform {
  cloud {
    organization = "openstack-lab01"
    workspaces {
      name = "kubernetes-binero-cluster"
    }
  }
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.40.0"
    }
  }
}
