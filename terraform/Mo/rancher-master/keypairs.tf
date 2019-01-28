resource "openstack_compute_keypair_v2" "rancher_node_keypair" {
  name = "rancher-node"
}