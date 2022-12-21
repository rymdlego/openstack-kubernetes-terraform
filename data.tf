data "openstack_networking_network_v2" "external_network" {
  name = "europe-se-1-1a-net0"
}

data "openstack_compute_flavor_v2" "node-flavor" {
  name = "hp.2x6"
}

data "openstack_compute_flavor_v2" "cp-flavor" {
  name = "gp.2x4"
}

data "openstack_compute_flavor_v2" "bastion-flavor" {
  name = "gp.1x2"
}

data "openstack_images_image_v2" "debian" {
  name = "debian-11-x86_64"
}

data "openstack_networking_secgroup_v2" "tf_secgroup_allopen" {
  name = "all-open"
}
