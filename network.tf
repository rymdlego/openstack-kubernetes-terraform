#### Networks
resource "openstack_networking_network_v2" "tf_network" {
  name           = "${var.resource_prefix}-${var.network_name}"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "tf_subnet" {
  name       = "${var.resource_prefix}-${var.subnet_name}"
  network_id = openstack_networking_network_v2.tf_network.id
  cidr       = var.network_cidr
  ip_version = 4
  allocation_pool {
    start = var.dhcp_start
    end   = var.dhcp_end
  }
}

#### Ports
resource "openstack_networking_port_v2" "tf_cp_ports" {
  for_each           = var.controlplanes
  name               = "${var.resource_prefix}-${each.value["name"]}"
  network_id         = openstack_networking_network_v2.tf_network.id
  admin_state_up     = "true"
  security_group_ids = ["${data.openstack_networking_secgroup_v2.tf_secgroup_allopen.id}"]
  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.tf_subnet.id
    ip_address = each.value["ip_address"]
  }
  allowed_address_pairs {
    ip_address = var.virtual_ip
  }
}

resource "openstack_networking_port_v2" "tf_node_ports" {
  for_each           = var.nodes
  name               = "${var.resource_prefix}-${each.value["name"]}"
  network_id         = openstack_networking_network_v2.tf_network.id
  admin_state_up     = "true"
  security_group_ids = ["${data.openstack_networking_secgroup_v2.tf_secgroup_allopen.id}"]
  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.tf_subnet.id
    ip_address = each.value["ip_address"]
  }
  allowed_address_pairs {
    ip_address = var.network_cidr
  }
}

resource "openstack_networking_port_v2" "tf_kubernetes_port" {
  name               = "${var.resource_prefix}-kubernetes"
  network_id         = openstack_networking_network_v2.tf_network.id
  admin_state_up     = "true"
  security_group_ids = ["${openstack_networking_secgroup_v2.tf_secgroup_external_kubernetes.id}"]
  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.tf_subnet.id
    ip_address = var.virtual_ip
  }
}

resource "openstack_networking_port_v2" "tf_bastion_port" {
  name               = "${var.resource_prefix}-bastion"
  network_id         = openstack_networking_network_v2.tf_network.id
  admin_state_up     = "true"
  security_group_ids = ["${openstack_networking_secgroup_v2.tf_secgroup_bastion.id}"]
  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.tf_subnet.id
    ip_address = var.bastion_ip
  }
}

#### Router
resource "openstack_networking_router_v2" "tf_router" {
  name                = "${var.resource_prefix}-${var.router_name}"
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external_network.id
}

resource "openstack_networking_router_interface_v2" "tf_router_interface" {
  router_id = openstack_networking_router_v2.tf_router.id
  subnet_id = openstack_networking_subnet_v2.tf_subnet.id
}

#### Floating IPs
resource "openstack_networking_floatingip_v2" "tf_floatip_kubernetes" {
  pool = "europe-se-1-1a-net0"
}

resource "openstack_networking_floatingip_v2" "tf_floatip_bastion" {
  pool = "europe-se-1-1a-net0"
}

resource "openstack_networking_floatingip_associate_v2" "tf_floatip_associate_kubernetes" {
  floating_ip = openstack_networking_floatingip_v2.tf_floatip_kubernetes.address
  port_id     = openstack_networking_port_v2.tf_kubernetes_port.id
}

resource "openstack_networking_floatingip_associate_v2" "tf_floatip_associate_bastion" {
  floating_ip = openstack_networking_floatingip_v2.tf_floatip_bastion.address
  port_id     = openstack_networking_port_v2.tf_bastion_port.id
}
