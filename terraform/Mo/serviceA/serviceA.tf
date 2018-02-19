resource "openstack_compute_instance_v2" "serviceA" {
  name            = "serviceA"
  flavor_name     = "g1.small"
  key_pair        = "my-keypair"
  security_groups = ["${openstack_compute_secgroup_v2.serviceA_secgroup_1.name}"]

  availability_zone = "SV1"

  block_device {
    uuid                  = "${openstack_blockstorage_volume_v1.serviceA_root_volume.id}"
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  network {
    name = "${module.region.regional_public_network_name}"
  }

  depends_on = ["openstack_blockstorage_volume_v1.serviceA_root_volume"]
}

resource "openstack_blockstorage_volume_v1" "serviceA_root_volume" {
  name     = "serviceA-root-volume"
  size     = 30
  image_id = "${data.openstack_images_image_v2.ubuntu.id}"

  availability_zone = "SV1"
}

resource "openstack_networking_floatingip_v2" "serviceA_floatip_1" {
  pool = "public_network"
}

resource "openstack_compute_floatingip_associate_v2" "serviceA_fip_attachment" {
  floating_ip = "${openstack_networking_floatingip_v2.serviceA_floatip_1.address}"
  instance_id = "${openstack_compute_instance_v2.serviceA.id}"
}
