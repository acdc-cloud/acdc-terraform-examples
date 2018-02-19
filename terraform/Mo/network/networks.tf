resource "openstack_networking_network_v2" "acdc_cloud_network" {
  name           = "acdc-1"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "acdc_subnet_1" {
  name       = "acdc-s-1"
  network_id = "${openstack_networking_network_v2.acdc_cloud_network.id}"
  cidr       = "192.168.100.0/24"
  ip_version = 4

  dns_nameservers = ["8.8.8.8", "8.8.4.4"]
}

resource "openstack_networking_router_v2" "acdc_router" {
  name                = "acdc-router"
  admin_state_up      = true
  external_network_id = "${data.openstack_networking_network_v2.public_network.id}"
}

resource "openstack_networking_router_interface_v2" "acdc_router_interface_1" {
  router_id = "${openstack_networking_router_v2.acdc_router.id}"
  subnet_id = "${openstack_networking_subnet_v2.acdc_subnet_1.id}"
}
