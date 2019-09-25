output "loadbalancer_address" {
  value = "http://${openstack_networking_floatingip_v2.floatip_1.address}"
}
