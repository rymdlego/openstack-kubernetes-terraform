resource "openstack_compute_keypair_v2" "tf_keypair" {
  name       = "ssh_pub_key"
  public_key = var.pub_ssh_key
}
