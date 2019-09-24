resource "openstack_networking_floatingip_v2" "rancher_master_floatip_1" {
  pool = "public_network"
}

resource "openstack_compute_floatingip_associate_v2" "rancher_master_fip_attachment" {
  floating_ip = openstack_networking_floatingip_v2.rancher_master_floatip_1.address
  instance_id = openstack_compute_instance_v2.rancher_master.id
}

