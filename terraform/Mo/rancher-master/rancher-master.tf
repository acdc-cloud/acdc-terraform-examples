resource "openstack_compute_instance_v2" "rancherMaster" {
  name            = "rancherMaster"
  flavor_name     = "g1.large_lowmem"
  key_pair        = "rancher-master"
  security_groups = ["acdc-secgroup-1",
    "${openstack_compute_secgroup_v2.rancherMaster_secgroup.name}",
    "${openstack_compute_secgroup_v2.rancher_cattle.name}"
  ]

  availability_zone = "SV2"

  block_device {
    uuid                  = "${openstack_blockstorage_volume_v1.rancherMaster_root_volume.id}"
    source_type           = "volume"
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }

  user_data = "${data.template_cloudinit_config.config.rendered}"

  network {
    name = "${module.region.regional_public_network_name}"
  }

  depends_on = ["openstack_blockstorage_volume_v1.rancherMaster_root_volume"]  
  depends_on = ["openstack_compute_keypair_v2.rancher_master_keypair"]
 
}

resource "openstack_blockstorage_volume_v1" "rancherMaster_root_volume" {
  name     = "rancherMaster-root-volume"
  size     = 40
  image_id = "${data.openstack_images_image_v2.ubuntu.id}"

  availability_zone = "SV2"
}

resource "openstack_networking_floatingip_v2" "rancherMaster_floatip_1" {
  pool = "public_network"
}
resource "openstack_compute_keypair_v2" "rancher_node_keypair" {
  name = "rancher-node"
}

resource "openstack_compute_keypair_v2" "rancher_master_keypair" {
  name = "rancher-master"
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

output "Rancher-master private key" {
  value = "${openstack_compute_keypair_v2.rancher_master_keypair.private_key}"
}
output "IP for Rancher" {
  value = "${openstack_networking_floatingip_v2.rancherMaster_floatip_1.address}"
}