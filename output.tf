output "float_ip_kubernetes" {
  description = "Floating IP kubernetes"
  value       = openstack_networking_floatingip_v2.tf_floatip_kubernetes.address
}

output "float_ip_bastion" {
  description = "Floating IP bastion"
  value       = openstack_networking_floatingip_v2.tf_floatip_bastion.address
}
