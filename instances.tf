# Create SSH bastion host
resource "openstack_compute_instance_v2" "tf_bastion" {
  name      = "${var.resource_prefix}-bastion"
  image_id  = data.openstack_images_image_v2.debian.id
  flavor_id = data.openstack_compute_flavor_v2.bastion-flavor.id
  key_pair  = "ssh_pub_key"
  network {
    port = openstack_networking_port_v2.tf_bastion_port.id
  }
  depends_on = [
    openstack_networking_subnet_v2.tf_subnet
  ]
}

# Create control planes
resource "openstack_compute_instance_v2" "tf_controlplanes" {
  for_each  = openstack_networking_port_v2.tf_cp_ports
  name      = each.value.name
  image_id  = data.openstack_images_image_v2.debian.id
  flavor_id = data.openstack_compute_flavor_v2.cp-flavor.id
  key_pair  = "ssh_pub_key"
  network {
    port = each.value.id
  }
  depends_on = [
    openstack_networking_subnet_v2.tf_subnet
  ]
}

# Create nodes
resource "openstack_compute_instance_v2" "tf_nodes" {
  for_each  = openstack_networking_port_v2.tf_node_ports
  name      = each.value.name
  image_id  = data.openstack_images_image_v2.debian.id
  flavor_id = data.openstack_compute_flavor_v2.node-flavor.id
  key_pair  = "ssh_pub_key"
  network {
    port = each.value.id
  }
  depends_on = [
    openstack_networking_subnet_v2.tf_subnet
  ]
}
