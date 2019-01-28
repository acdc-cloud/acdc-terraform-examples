resource "openstack_networking_floatingip_v2" "rancherMaster_floatip_1" {
  pool = "public_network"
}

resource "openstack_compute_floatingip_associate_v2" "rancherMaster_fip_attachment" {
  floating_ip = "${openstack_networking_floatingip_v2.rancherMaster_floatip_1.address}"
  instance_id = "${openstack_compute_instance_v2.rancherMaster.id}"

  depends_on = ["openstack_compute_keypair_v2.rancher_node_keypair"]
  provisioner "file" {
    content     = "${openstack_compute_keypair_v2.rancher_node_keypair.private_key}"
    destination = "~/rancher-node.pem"

    connection {
      type = "ssh"
      host = "${openstack_networking_floatingip_v2.rancherMaster_floatip_1.address}"
      user = "ubuntu"
      private_key = "${openstack_compute_keypair_v2.rancher_master_keypair.private_key}"
    }
  }
}