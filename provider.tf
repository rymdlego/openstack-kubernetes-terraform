provider "openstack" {
  user_name = var.openstack_username
  tenant_id = var.openstack_tenant_id
  password  = var.openstack_password
  auth_url  = var.openstack_auth_url
  region    = var.openstack_region
}
