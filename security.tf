resource "openstack_networking_secgroup_v2" "tf_secgroup_external_kubernetes" {
  name        = "kubernetes-ext-secgroup"
  description = "Kubernetes external access security group"
}

resource "openstack_networking_secgroup_v2" "tf_secgroup_bastion" {
  name        = "kubernetes-bastion-secgroup"
  description = "Bastion server security group"
}

resource "openstack_networking_secgroup_rule_v2" "tf_secgroup_rule_ssh_bastion" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.tf_secgroup_bastion.id
}

resource "openstack_networking_secgroup_rule_v2" "tf_secgroup_rule_api_ext" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 6443
  port_range_max    = 6443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.tf_secgroup_external_kubernetes.id
}
